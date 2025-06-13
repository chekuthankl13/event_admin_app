import 'package:event_admin/core/config/config.dart';
import 'package:flutter/material.dart';

class CustomField {
  TextFormField simple({
    required cntr,
    required leadingIc,
    required hint,
    required label,
    isRead = false,
    isReq = true,
    ispasw = false,
    isDense = false,
    isfilter = false,
    isnum = false,
    isTwoLine = false,
    suffix,
    obsure,
    ontap,
    onchange,
    trailIc,
    isLead = true,
  }) {
    return TextFormField(
      controller: cntr,
      readOnly: isRead,
      maxLines: isTwoLine ? 2 : 1,
      onTap: isRead ? ontap : null,
      autocorrect: true,
      obscureText: ispasw ? obsure : false,
      keyboardType: isnum ? TextInputType.numberWithOptions() : null,
      validator: isReq
          ? (val) {
              if (val!.isEmpty) {
                return "*required !!";
              }
              return null;
            }
          : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      onChanged: onchange,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: Config.redAccentLigthClr),
        hintText: hint,
        label: Text(
          label,
          style: TextStyle(color: Config.grey2Clr, fontWeight: FontWeight.w300),
        ),
        hintStyle: isfilter
            ? TextStyle(color: Config.grey2Clr, fontWeight: FontWeight.w300)
            : TextStyle(color: Config.grey2Clr, fontWeight: FontWeight.w300),
        isDense: isDense,
        suffixIcon:
            suffix ??
            (trailIc != null ? Icon(trailIc, color: Colors.grey) : null),
        prefixIcon: isLead
            ? Icon(leadingIc, color: Config.violetClr)
            : null,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }




   TextFormField readOnly({
    required cntr,
    required hint,
    isreq = false,
    ontap,
    isdense = true,
    ic,
  }) {
    return TextFormField(
      controller: cntr,
      readOnly: true,
      onTap: ontap,
      autocorrect: true,
      // style: const TextStyle(fontSize: 12),
      validator: (value) {
        if (value!.isEmpty) {
          return "*required !!";
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,

        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Config.redAccentLigthClr),
        hintStyle: TextStyle(
          color: Config.grey2Clr,
          fontWeight: FontWeight.w300,
        ),
        hintText: hint,
        isDense: isdense,
        suffixIcon: Icon(
          ic ?? Icons.arrow_drop_down,
          color: Config.redAccentLigthClr,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Config.greyClr),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}