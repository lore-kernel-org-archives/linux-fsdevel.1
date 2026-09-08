Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851C27A462
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788843062; cv=pass; b=JdfandTxmIiz3wVyPovmXWYoE/3UqT49gl1XvBJ0G4nxcfp7FveUFv13yWeRDkvKQL+UTWfnmPiMYF4YuRsvRUgSccUODFhpPg1KKDDh7FKGPXgtr8ejJ0txleYTgXtmK/o5034GAItp9qAkxEUPF+vnyvxhIun0hG3AnblscFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788843062; c=relaxed/simple;
	bh=ku42uUX7ZbH/7LpItS9aH3fLeAK5HsS4meKJPMvm4v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/Yt7tDn8mdapkQJzZBOYCptblHjE47SH/+vGJtSPrzXfQ6FVrqFmMDuRaP6ZgO6q79d6HNcOLDvZzcNRq0uAxiuo/t8CwXASDXknHfLStqA5DE+sEjPGAs3Tzd94Ue+gvtTyliHrPVDBKpYyPVyHHDFihRz4LiGWKYj+Ld3TXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=HPU0XU05; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="HPU0XU05"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d944747d41so43829285ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 21:51:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788843060; cv=none;
        d=google.com; s=arc-20260327;
        b=WriTsjDsAzvd2aQSysC9ukgdBhCDP8mQFB8F5FmXbTH3eXHknT+1LVMNdpSamrQ5ye
         4/YYNSmplZgfpaF7NIkTHCmkQRvuy7wlMWtPpSxqe7TEMJZRvmCJKlY4hdZy5VrhiDRH
         1MZT+HNRxST6zS6wCDPSaOx1WdQXS+FmDCy6CD4VkJ5j/SzLl7ev8EWcqpOS/OKxkazY
         9lQW1vKZBurDJB4uRxiioc14T6lZlJd/54IaIxxYjf2uXDfs+H/Hwh5xeqaTefS9ct47
         Hbu1RZF8rLI8jO6tr7KuQOthB2i/1955S1Gq3bt5ZtBo6AgjbW2N++PFAVpvZwQvY3fl
         GGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MWbLzTpbSRidQp2YUKLqdKPg9dESEJFx6zLcf8UCnwA=;
        fh=EOlh8Pp9EdvP3nW9R5vkvCA+9VgzCXsk+56OIFtdccg=;
        b=VnsZASsL/ggRcZksBjZrtUsjSZDs2VqUDqGcs2ordCxwPIWOI+EeezI2xsYmnrb9+a
         xgz+7C/+Kb7GRo2ioeRVrsqYY8fuWsX2libxs1i1Zxtao+HjReP6nKRn94sD6bKYhZVZ
         1mYhHeEy5lETVq5GtxAU8Lfp6/eXlSqsCJsXN1bNO6tS+ntUWDMi8Xv6OyPP5JcL/mLT
         9gkQdLpqr5Hr+EfW2Eb6/UyJi1WCqL9UsgN0dnxQBPs/FbX4wk4qVyijtvYKHzHrOxlo
         n0fyaxKppkrpkZ6vT6l2R3vOxfDKovRyyFu7mc2ZSsRWHTnIKqoh+VI3DIGH106vhsai
         DOlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1788843060; x=1789447860; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWbLzTpbSRidQp2YUKLqdKPg9dESEJFx6zLcf8UCnwA=;
        b=HPU0XU05dxS49ThX0e7TcSAwHU+bXP4qkFwrrgEkOmsUvSnHWxBYnRnu30Lm99d8ie
         2psE5wnAOHOiM2HMR9i2SoUjmqrvj2AZFH1ZxYf1+Dn06RBJhAzHDZljLDteKm7X2T5Z
         xtac9zjJWW5e/TAmxbuBjyimCWHw0h+rECjC/a744ZwcEBpNLVwoiYlpMfHFnfWBqq/Z
         ZLaw+x6JzqPcahtx0Txl7KoWcvo+8wk4APIvVUFWcxaPve27VFiAm2kixIMid2e3LnNh
         Ck/LcdtPFjjVsC6i20sR3w5D2g0Ri3ewc9Ua1JnyuVB4GHnqdXaMg8P2/1W3bsFvbxak
         zTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788843060; x=1789447860;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MWbLzTpbSRidQp2YUKLqdKPg9dESEJFx6zLcf8UCnwA=;
        b=b1B0OCgYXJQ4Or36laGujbS/cA6oBzd+3l1RbCROmJzcKw+bkp6yl3Jom1tHHc1SPg
         J/S6AgiEZDgMsLveKOEW9t+mY3nugNMnWBxhafPWknVECfJ08ITVkOVGkTjPgQ1VrdU/
         LWlMEaPFQcFqBQ9rXJWQ6flSjgUsz4d4lCEdR7JoN0ZR+1yR5PjJZl7Ryvl9315LYOh7
         DX5EqP6AtxevPolvLyByKAs5SvLSfCJTpk3+Pl4veFrxzHA8212fSUMnVT1u/ADMgk6U
         07PW0b7hZ+2/ys+PjAdD9E9T//jpNcE/rPIPKVJIycaqDtYMqCr/dvHqOiKYSIq3HkpR
         tvWg==
X-Forwarded-Encrypted: i=1; AKwUvByZUoB6yGVYop0ALxwAWDiq2vHmRsTUXCwiblNIaDtjEl25S5PoDaS8xnfZqsC9azV1inF1WhcJaNcjEmgB@vger.kernel.org
X-Gm-Message-State: AFuF++lWtA/P5G7P3oYn72NvtzAgBv8tg7vY9+atXDr6YrJXjKLTMqbv
	XsG1dT3R65V+wR3dEa36VqTNTYUsIBdXyXZ3aWpGHDIyxk4wqdmTKDn72hXEORuqIX7fU0tQJv+
	cmruOu3DUShdtUGhVXNYe9yn4/oS32ep8o16bsxWQ
X-Gm-Gg: AYBFou0ZQetwyA03Z9bWQZwODEHaJ395Dqjbvi6agTcOY2pCGBgt0qTJu7r1bIRotXj
	V/Nm7g1/GtB66qv/k4mwlpDRWPO4Hu9sCT1OVQpRWkO+U4p7X9iXtgnfxpttTQj3W2DCJHVOqy+
	5JRzdszuZ/WliD324TG7V5xwaFvAlHgVDUIb5C3OqI7Ljgy+QEEuePhIsOb+TUpao5dMKvlw4s2
	Vsewj1nDoVtSoq6GfkOhAbGeokC1sNAM+lV3m/czDJEtVXvrjstob4xseEodMFeVB+Y2aa91uXu
	v7zKMNXrA9YsIJSEn/UipOeFWcePF+eqCFJm5A9ekzrmEzBu7TDAgJvcxUYlg1F4HsdZPkqymsM
	OQwKU256LRV9BlQ2KIBXk7UqQb9Gy1Jjc
X-Received: by 2002:a17:902:8a8d:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2db122edd50mr288389825ad.5.1788843058747; Mon, 07 Sep 2026
 21:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCgYP920GT68hAJK6Trjyv1kGv2dZAuem4LEunycQ=POww@mail.gmail.com>
 <apG98qJyYqvcTXIh@yaupon>
In-Reply-To: <apG98qJyYqvcTXIh@yaupon>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Mon, 7 Sep 2026 21:50:47 -0700
X-Gm-Features: AcwNN1VEDWIXd7xQleRkSk4sjyC_iC9YFu7sqDm8tMiDGbWikWjVERdX3hee9jw
Message-ID: <CA+0ovCi_MdcoT7-JuouAYXuGrN5_iFpH344VwqT3hsnqmbEM2w@mail.gmail.com>
Subject: Re: [BUG] ecryptfs leaks an inode on lookup failure -> kernel BUG in generic_shutdown_super()
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001446ae065af17bb1"

--0000000000001446ae065af17bb1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the delayed response; reproducer attached! Thanks!

On Fri, Aug 28, 2026 at 9:57=E2=80=AFAM Tyler Hicks <code@tyhicks.com> wrot=
e:
>
> On 2026-08-27 20:18:11, Farhad Alemi wrote:
> > Hello,
>
> Hi - Thank you for the report.
>
> > As part of the kernel research at ASU's SEFCOM
> > lab, we hit the crash below. Crash reports can be found here:
> >
> >   https://github.com/farhad-alemi/public_bug_reports/tree/main/128-ecry=
ptfs-i_new-inode-leak-lookup-failure/
> >
> >   ecryptfs_i_size_read: Error attempting to initialize the lower file
> > for the dentry with name [victim]; rc =3D [-26]
> >   VFS: Busy inodes after unmount of ecryptfs (ecryptfs)
> >   kernel BUG at fs/super.c:779!
> >   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >   Call Trace:
> >    kill_anon_super+0x3b/0x70
> >    ecryptfs_kill_block_super+0x44/0xa0
> >    deactivate_locked_super+0xbc/0x110
> >    cleanup_mnt+0x437/0x4d0
> >    task_work_run+0x1d9/0x270
> >    exit_to_user_mode_loop+0x14e/0x540
> >    do_syscall_64+0x317/0x510
> >   Kernel panic - not syncing: Fatal exception
> >
> > Our reproducer.c is available upon request.
>
> Yes, please provide reproducer.c.
>
> Tyler
>
> > Happy to test a patch if that would help.
> >
> > Regards,

--0000000000001446ae065af17bb1
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mts6yhci0>
X-Attachment-Id: f_mts6yhci0

LyoKICogUmVwcm9kdWNlciBmb3IgMTI4LWVjcnlwdGZzLWlfbmV3LWlub2RlLWxlYWstbG9va3Vw
LWZhaWx1cmUKICoKICogQnVpbGQ6IGdjYyAtc3RhdGljIC1PMCAtdyAtbyByZXBybyByZXByb2R1
Y2VyLmMKICogUnVuOiAgIGFzIHJvb3QsIGluIGEgZGlzcG9zYWJsZSBWTS4gSXQgaXMgZXhwZWN0
ZWQgdG8gcGFuaWMgdGhlIGtlcm5lbC4KICovCiNkZWZpbmUgX0dOVV9TT1VSQ0UKI2luY2x1ZGUg
PGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUg
PHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL21vdW50Lmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgoj
aW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2RlZmluZSBXT1JL
X0RJUiAgICIvZWN3b3JrIgojZGVmaW5lIExPV0VSX0RJUiAgV09SS19ESVIgIi9sb3dlciIKI2Rl
ZmluZSBVUFBFUl9ESVIgIFdPUktfRElSICIvdG9wIgojZGVmaW5lIFZJQ1RJTSAgICAgTE9XRVJf
RElSICIvdmljdGltIgoKLyogInNpZz0iIGlzIG1lbWNtcCdkIG92ZXIgRUNSWVBURlNfU0lHX1NJ
WkVfSEVYIGJ5dGVzIGFuZCBpcyBhbHNvIHRoZQogKiBkZXNjcmlwdGlvbiBvZiB0aGUgInVzZXIi
IGtleSB0aGF0IGVjcnlwdGZzIHJlcXVlc3Rfa2V5KClzICovCiNkZWZpbmUgS0VZX1NJRyAiMDEy
MzQ1Njc4OWFiY2RlZiIKCiNkZWZpbmUgRUNSWVBURlNfTUFYX0VOQ1JZUFRFRF9LRVlfQllURVMg
NTEyCiNkZWZpbmUgRUNSWVBURlNfTUFYX0tFWV9CWVRFUyA2NAojZGVmaW5lIEVDUllQVEZTX1NB
TFRfU0laRSA4CiNkZWZpbmUgRUNSWVBURlNfUEFTU1dPUkRfU0lHX1NJWkUgMTYKCnN0cnVjdCBl
Y3J5cHRmc19zZXNzaW9uX2tleSB7Cgl1bnNpZ25lZCBpbnQgZmxhZ3M7Cgl1bnNpZ25lZCBpbnQg
ZW5jcnlwdGVkX2tleV9zaXplOwoJdW5zaWduZWQgaW50IGRlY3J5cHRlZF9rZXlfc2l6ZTsKCXVu
c2lnbmVkIGNoYXIgZW5jcnlwdGVkX2tleVtFQ1JZUFRGU19NQVhfRU5DUllQVEVEX0tFWV9CWVRF
U107Cgl1bnNpZ25lZCBjaGFyIGRlY3J5cHRlZF9rZXlbRUNSWVBURlNfTUFYX0tFWV9CWVRFU107
Cn07CgpzdHJ1Y3QgZWNyeXB0ZnNfcGFzc3dvcmQgewoJdW5zaWduZWQgaW50IHBhc3N3b3JkX2J5
dGVzOwoJaW50IGhhc2hfYWxnbzsKCXVuc2lnbmVkIGludCBoYXNoX2l0ZXJhdGlvbnM7Cgl1bnNp
Z25lZCBpbnQgc2Vzc2lvbl9rZXlfZW5jcnlwdGlvbl9rZXlfYnl0ZXM7Cgl1bnNpZ25lZCBpbnQg
ZmxhZ3M7Cgl1bnNpZ25lZCBjaGFyIHNlc3Npb25fa2V5X2VuY3J5cHRpb25fa2V5W0VDUllQVEZT
X01BWF9LRVlfQllURVNdOwoJdW5zaWduZWQgY2hhciBzaWduYXR1cmVbRUNSWVBURlNfUEFTU1dP
UkRfU0lHX1NJWkUgKyAxXTsKCXVuc2lnbmVkIGNoYXIgc2FsdFtFQ1JZUFRGU19TQUxUX1NJWkVd
Owp9OwoKLyogNzQwIGJ5dGVzIG9uIHg4Nl82NDsgZWNyeXB0ZnMgdmFsaWRhdGVzIHRoZSBwYXls
b2FkIHNpemUgKi8Kc3RydWN0IGVjcnlwdGZzX2F1dGhfdG9rIHsKCXVuc2lnbmVkIHNob3J0IHZl
cnNpb247Cgl1bnNpZ25lZCBzaG9ydCB0b2tlbl90eXBlOwoJdW5zaWduZWQgaW50IGZsYWdzOwoJ
c3RydWN0IGVjcnlwdGZzX3Nlc3Npb25fa2V5IHNlc3Npb25fa2V5OwoJdW5zaWduZWQgY2hhciBy
ZXNlcnZlZFszMl07Cgl1bmlvbiB7CgkJc3RydWN0IGVjcnlwdGZzX3Bhc3N3b3JkIHBhc3N3b3Jk
OwoJfSB0b2tlbjsKfSBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKTsKCnN0YXRpYyBpbnQgYWRkX2Vj
cnlwdGZzX2F1dGhfdG9rX2tleSh2b2lkKQp7CglzdHJ1Y3QgZWNyeXB0ZnNfYXV0aF90b2sgYXV0
aF90b2s7CgoJbWVtc2V0KCZhdXRoX3RvaywgMCwgc2l6ZW9mKGF1dGhfdG9rKSk7CglhdXRoX3Rv
ay52ZXJzaW9uID0gMHgwMDA0OwoJYXV0aF90b2sudG9rZW5fdHlwZSA9IDA7CQkJLyogRUNSWVBU
RlNfUEFTU1dPUkQgKi8KCWF1dGhfdG9rLnRva2VuLnBhc3N3b3JkLnBhc3N3b3JkX2J5dGVzID0g
MTY7CglhdXRoX3Rvay50b2tlbi5wYXNzd29yZC5oYXNoX2l0ZXJhdGlvbnMgPSAxOwoJYXV0aF90
b2sudG9rZW4ucGFzc3dvcmQuc2Vzc2lvbl9rZXlfZW5jcnlwdGlvbl9rZXlfYnl0ZXMgPSAxNjsK
CWF1dGhfdG9rLnRva2VuLnBhc3N3b3JkLmZsYWdzID0gMHgwMjsJLyogU0VTU0lPTl9LRVlfRU5D
UllQVElPTl9LRVlfU0VUICovCgltZW1zZXQoYXV0aF90b2sudG9rZW4ucGFzc3dvcmQuc2Vzc2lv
bl9rZXlfZW5jcnlwdGlvbl9rZXksIDB4NDEsIDE2KTsKCW1lbWNweShhdXRoX3Rvay50b2tlbi5w
YXNzd29yZC5zaWduYXR1cmUsIEtFWV9TSUcsIDE2KTsKCglyZXR1cm4gc3lzY2FsbChfX05SX2Fk
ZF9rZXksICJ1c2VyIiwgS0VZX1NJRywgJmF1dGhfdG9rLAoJCSAgICAgICBzaXplb2YoYXV0aF90
b2spLCAtMyAvKiBLRVlfU1BFQ19TRVNTSU9OX0tFWVJJTkcgKi8pIDwgMDsKfQoKc3RhdGljIGlu
dCBjb3B5X3NlbGZfdG9fdmljdGltKHZvaWQpCnsKCWNoYXIgYnVmWzY1NTM2XTsKCWludCBzZWxm
X2ZkID0gb3BlbigiL3Byb2Mvc2VsZi9leGUiLCBPX1JET05MWSk7CglpbnQgdmljdGltX2ZkID0g
b3BlbihWSUNUSU0sIE9fUkRXUiB8IE9fQ1JFQVQgfCBPX1RSVU5DLCAwNzU1KTsKCXNzaXplX3Qg
bjsKCglpZiAoc2VsZl9mZCA8IDAgfHwgdmljdGltX2ZkIDwgMCkKCQlyZXR1cm4gMTsKCXdoaWxl
ICgobiA9IHJlYWQoc2VsZl9mZCwgYnVmLCBzaXplb2YoYnVmKSkpID4gMCkKCQlpZiAod3JpdGUo
dmljdGltX2ZkLCBidWYsIG4pICE9IG4pCgkJCXJldHVybiAxOwoJY2xvc2Uoc2VsZl9mZCk7Cglj
bG9zZSh2aWN0aW1fZmQpOwoJcmV0dXJuIGNobW9kKFZJQ1RJTSwgMDc1NSk7Cn0KCmludCBtYWlu
KGludCBhcmdjLCBjaGFyICoqYXJndikKewoJc3RydWN0IHN0YXQgc3RhdF9idWY7CgoJLyogcmUt
ZXhlYydlZCBhcyB0aGUgcHJvY2VzcyB0aGF0IGtlZXBzIFZJQ1RJTSBidXN5ICovCglpZiAoYXJn
YyA+IDEpCgkJZm9yICg7OykKCQkJcGF1c2UoKTsKCglta2RpcihXT1JLX0RJUiwgMDc3Nyk7Cglt
b3VudCgibm9uZSIsIFdPUktfRElSLCAidG1wZnMiLCAwLCAiIik7Cglta2RpcihMT1dFUl9ESVIs
IDA3NzcpOwoJbWtkaXIoVVBQRVJfRElSLCAwNzc3KTsKCglpZiAoY29weV9zZWxmX3RvX3ZpY3Rp
bSgpKSB7CgkJcHJpbnRmKCJjYW5ub3Qgc3RhZ2UgJXM6ICVzXG4iLCBWSUNUSU0sIHN0cmVycm9y
KGVycm5vKSk7CgkJcmV0dXJuIDE7Cgl9CgoJLyogRXhlY3V0aW5nIFZJQ1RJTSBtYWtlcyBkZW55
X3dyaXRlX2FjY2VzcygpIHJlZnVzZSBldmVyeSBsYXRlcgoJICogT19SRFdSIG9wZW4gb2YgaXQg
d2l0aCAtRVRYVEJTWSAtLSBpbmNsdWRpbmcgdGhlIG9uZSBlY3J5cHRmcycKCSAqIHByaXZpbGVn
ZWQga3RocmVhZCBkb2VzLCB3aGljaCBpcyB3aGF0IG1ha2VzIHRoZSBsb29rdXAgZmFpbC4gKi8K
CWlmIChmb3JrKCkgPT0gMCkgewoJCWNoYXIgKmFyZ3Zfc2xlZXBlcltdID0geyAoY2hhciAqKSJ2
aWN0aW0iLCAoY2hhciAqKSJidXN5IiwgTlVMTCB9OwoJCWV4ZWN2KFZJQ1RJTSwgYXJndl9zbGVl
cGVyKTsKCQlfZXhpdCgxMjcpOwoJfQoJc2xlZXAoMSk7CgoJaWYgKGFkZF9lY3J5cHRmc19hdXRo
X3Rva19rZXkoKSkgewoJCXByaW50ZigiYWRkX2tleTogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7
CgkJcmV0dXJuIDE7Cgl9CglpZiAobW91bnQoTE9XRVJfRElSLCBVUFBFUl9ESVIsICJlY3J5cHRm
cyIsIDAsCgkJICAic2lnPSIgS0VZX1NJRyAiLGNpcGhlcj1hZXMsZWNyeXB0ZnNfa2V5X2J5dGVz
PTE2IikpIHsKCQlwcmludGYoImVjcnlwdGZzIG1vdW50OiAlc1xuIiwgc3RyZXJyb3IoZXJybm8p
KTsKCQlyZXR1cm4gMTsKCX0KCgkvKiBlY3J5cHRmc19sb29rdXBfaW50ZXJwb3NlKCkgLT4gZWNy
eXB0ZnNfaV9zaXplX3JlYWQoKSBmYWlscywgYW5kIGl0cwoJICogZXJyb3IgcGF0aCByZXR1cm5z
IHdpdGhvdXQgdW5sb2NrX25ld19pbm9kZSgpIGFuZCB3aXRob3V0IGlwdXQoKSwgc28KCSAqIHRo
aXMgSV9ORVcgaW5vZGUgc3RheXMgb24gc2ItPnNfaW5vZGVzLiAqLwoJc3RhdChVUFBFUl9ESVIg
Ii92aWN0aW0iLCAmc3RhdF9idWYpOwoKCS8qIHRoZSBsZWFrZWQgaW5vZGUgaXMgc3RpbGwgdGhl
cmU6IGJ1c3ktaW5vZGUgY2hlY2sgLT4gQlVHKCkgKi8KCXVtb3VudDIoVVBQRVJfRElSLCAwKTsK
CXJldHVybiAwOwp9Cg==
--0000000000001446ae065af17bb1--
