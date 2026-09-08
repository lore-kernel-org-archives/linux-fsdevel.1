Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1653101A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788840679; cv=pass; b=bq8CMw5XPD9s3LgRs7VtQl7EGCK2MtoQESIx7T+fv5BBEQZHW0ury4iuzntqzmJSoh1odskTDFqYHF+bC+wl9z75eZYcPHILI0OwOwmnAm/3s0c3AFjTiZc7b5svClqw+YaN8F6nGtv5PsPTjVsCAHm3yNrhSbUuWYqxQmlfHko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788840679; c=relaxed/simple;
	bh=jSczsniPhvvQCy37MO6Dre5VLhSUR1qB0JIGD3RBcOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyEQZPaOa+Wor/PBDpANTG0gJDhqhOY5VRy7UUirGqOdylwA8APj1SiR2LMdW5NIV9tFTywm6eeU3eZirlfqIQoNCsr+PhcdgAJn5sP2vCen1PaHTHO0S4jVnSUaPNTr0bqnVvFWn5vfreOwQj21+mLUodq8+GLXTRrAx8ocPq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=QCpDVaLL; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="QCpDVaLL"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso2876504a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 21:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788840675; cv=none;
        d=google.com; s=arc-20260327;
        b=Vd0u5UlHopymHgc/wKgRGLxfUqc3akB1BsgkYc7Nm9yAcS40MhzQxOhsaesQwFsUgy
         PIrHHJt0nSUnFJtmm+/8vBJ3Yw57Kelo0k/GWV4N1h3jGk4r/z+PKkUNggfNqoMeaYEv
         FeMaYfnS0Yi4F8HjWcsYrCtl62R9xiVD6RjnaIAxqZH8Bi5/JwblDrt/XRjBYE2qKBv1
         77ox9uueeGdTTJYtp0AeHNC+TtUqMnmojo2HhmdOT3D9KdwgQOCPYjgOlvZsagw+sXtF
         9f9wCx8acdyZKHo0GfMZe+rqEPSNXEoiCtK9i9IQ+LHMLb1NGhxgpCevpadcfHCsUJBx
         kCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NACF1mHDsALhIevCYN4DBwvAKGHyBbmDprBubQkPOns=;
        fh=7n3Wt3SD1Pn1G/pm5mNQpTIqnJXTYBoErGRIaThG4sQ=;
        b=EXlxJmlZcDpR2maSVQDzyRHXvK0Tux7rh4Qc2bFbdJLlrBIRFtMabFzIRo/MLLwcLX
         PpHKSyCuPoUh6MG9P/oP0C35+SexLaiHJaEneeggrx0g+CuyILeT6S9lrMFiRop2Rlwu
         3+LAVvaMUdB+LBKzxywvjZl+Vt2h5W3gmD3GLk0RkEExYhAC3wja2IMTatBCS5XO2kkS
         ZFZv0bdjxOATdZdzEphMrY9xK81LadKFSWhAUNE2DhPld17SAsX0pNFd6eqtyhQCigf1
         GCpALJ6MG5VQ7r0j8/EOZPlgF7RPCR6Sf4DO8T49yDL6SnaHtOKnDgULcKrqr/nnAsSV
         28gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1788840675; x=1789445475; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NACF1mHDsALhIevCYN4DBwvAKGHyBbmDprBubQkPOns=;
        b=QCpDVaLLdDovkNacqCQznPv7E1JeEyKyTzZe3ht1RYyTt5GZf1iWrjvTnmmz/q7SU0
         SR2Bwr3cX2H7t62lYn6KSdeD22pZuke9rZFiXJMXIPIePQqUXOcwCH0M12jAdZi3qsNg
         XyQtVLTQ6ByFusnwkXHig/705BQWB9ZZF3koEmTLT55HzJ51H6I9p3QYL/rKX8C+3si7
         EL6EMLLb6ttm4EzGw1hN0tvlItIFyA0DGvIbjz9wZunfyGlG4JHUTFZfQUYqXmi/6RgS
         eL1CQslXbudJkKoSAVQGv4YrxmoE8/G9SoBW9TXXRdNTKj+UYYkvhz3W7zt2abAkttWv
         JS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788840675; x=1789445475;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NACF1mHDsALhIevCYN4DBwvAKGHyBbmDprBubQkPOns=;
        b=b5/jcp64mg4Skyc/QOfpY6ZDNdkWGT8g3DLbR7xEsezm4jANzyHPMzMzF7bk59fxm4
         f20SatyLmAmYJEcZQ2g7hcSVgSXIJSKmpC0H3Axqh3OLqt9p+Bm4zsrdFfpfnrAkPXY9
         kAhQkqHz9872Ad7B4JqjdR0Q/FeM3GoBNAv6csK6CgMkccfYJnFKj3YA+TdnTyRcjMro
         /YJ0FNkpgGhWkMX/wF2lnOkplm1AKcOyDlul+Xem3AegldyLYtA8PizNlbTis0oJoHvy
         4f1n+6lY6zhXIaHb1YpLznuKZ+FVQHH/yZLBOiv4t20rCoAh3CwB4H2B3i9EdGOCMoRi
         kVFg==
X-Forwarded-Encrypted: i=1; AKwUvBwD8dNeqZ3tpWK+sdsTD2PgDEyOonWkt+J+4keF+oAxwr1oiXU3BuJ7/b70+v1zK0iZIL5sWatzYR/1P2Vx@vger.kernel.org
X-Gm-Message-State: AFuF++mf4xJ1i0semCLHCKWtcPSVFVyiXxcsojKP6feMvEyKsySnOb+s
	G+SDfDduogfc0N++i+wukE3wA544f9SsbmQtbget8Prik2f+2+LoJRBOy+MN/yEwlSnHbcmyqlf
	09aL/5pzQuM/Oy0OhqY2BCcs/AvCbNTWGoZLIgyn09PbKGDywRFjQKvZj
X-Gm-Gg: AYBFou0QWACgpsu6Dzcr3w10DDbfesQY6CGbOJwfNb4HNsM+tvAzviIUNuVkvOMvNn+
	dKb4A1jn30fMTMRQhDzmUUJYvTjgnSF3K5HogLtKthD0eLpukX/8Wa0UROOYWVjwmyIcdWL4KGz
	J8ZXnwZ1a/YhA5gwzRYbqp4+vj07ZoCs4QQE/yLu5uEpPDO9UoJbdbDUW66BcvPDC4WRR9M8DK9
	LW6QuCT578lBKFpZxHModGZyDXXPYnxCRcQhDQSncKrc870JdPCcpLZfu3gkpTXEUaVr6JN+GYf
	boEV8Npg2L5T0J8YRvFJMnbFDUPWhjHpvHzOvBrTAR61ivyX9kdspta342iQtGA2jkUwUBWpSs7
	FH+Zr6qBMy/tQsg1bmKEg3lIK267Idek=
X-Received: by 2002:a17:90b:56cf:b0:398:dcf6:d40e with SMTP id
 98e67ed59e1d1-39b262aa580mr41210459a91.17.1788840674554; Mon, 07 Sep 2026
 21:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovCiKb8axo+R-RsqzGbUsrVE0AcLbHqy=+-c9oSMCAqL1fA@mail.gmail.com>
 <apGbKdJiMx8nCfEl@mit.edu>
In-Reply-To: <apGbKdJiMx8nCfEl@mit.edu>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Mon, 7 Sep 2026 21:11:02 -0700
X-Gm-Features: AcwNN1UYBCSH5A2hJgM3PpIqoboOHM6LnyVHWwC7eYjFsBSpLnGI_b-UeW3bNKo
Message-ID: <CA+0ovCgxFN3TLpdS_O_Z48sARuQ-WR-JLDCqQWEmd9ELtkzddA@mail.gmail.com>
Subject: Re: [BUG] WARNING in ext4_journalled_invalidate_folio
To: Theodore Tso <tytso@mit.edu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f86613065af0ec65"

--000000000000f86613065af0ec65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attaching the reproducer; thanks!

On Fri, Aug 28, 2026 at 7:31=E2=80=AFAM Theodore Tso <tytso@mit.edu> wrote:
>
> On Thu, Aug 27, 2026 at 10:45:30PM -0500, Farhad Alemi wrote:
> > Hello,
> >
> > As part of the kernel research at ASU's SEFCOM
> > lab, we hit the crash below. Crash reports can be found here:
> >
> >   https://github.com/farhad-alemi/public_bug_reports/tree/main/172-warn=
ing-in-ext4-journalled-invalidate-folio/
>
> Please send the reproducer.  Note that if it requries a maliciously
> fuzzed file system, we consider this to be a minor bug (especially if
> the maliciously file system would be fixed when the system
> administrator runs fsck on the file system first), and not "security"
> issue, so feel free to just send it to the list.
>
> Cheers,
>
>                                         - Ted

--000000000000f86613065af0ec65
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mts5j3u30>
X-Attachment-Id: f_mts5j3u30

LyoKICogV0FSTklORyBpbiBleHQ0X2pvdXJuYWxsZWRfaW52YWxpZGF0ZV9mb2xpbywgZnMvZXh0
NC9pbm9kZS5jLgogKi8KI2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZmNudGwuaD4KI2lu
Y2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4K
I2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN5cy9z
dGF0Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNkZWZpbmUgSU1BR0UJCSIvdG1wL2V4dDQuaW1n
IgojZGVmaW5lIE1PVU5UUE9JTlQJIi9tbnQvZXh0NGoiCiNkZWZpbmUgTlJfV1JJVEVSUwk2CiNk
ZWZpbmUgTlJfRlNZTkNFUlMJMgoKc3RhdGljIHVuc2lnbmVkIGNoYXIgKnNob3J0X2NvcHlfc291
cmNlOwkvKiByZWFkYWJsZSBwYWdlLCB0aGVuIFBST1RfTk9ORSAqLwpzdGF0aWMgdm9sYXRpbGUg
aW50IHN0b3A7CgovKiBTdHJhZGRsZSBpX3NpemUgaW5zaWRlIG9uZSBmb2xpbywgdGhlbiB3cml0
ZSBwYXN0IGl0IHdpdGggYSBjb3VudCB0aGUKICogc291cmNlIGNhbm5vdCBzYXRpc2Z5OiB0aGUg
d3JpdGVfZW5kIHNlZXMgYSBzaG9ydCBjb3B5IGFuZCB0cnVuY2F0ZXMuICovCnN0YXRpYyB2b2lk
ICpwYXJ0aWFsX3dyaXRlcih2b2lkICphcmcpCnsKCWxvbmcgaWQgPSAobG9uZylhcmc7Cgl1bnNp
Z25lZCBsb25nIHJvdW5kID0gMDsKCWNoYXIgcGF0aFs2NF07CglpbnQgZmQ7CgoJc25wcmludGYo
cGF0aCwgc2l6ZW9mKHBhdGgpLCBNT1VOVFBPSU5UICIvdyVsZCIsIGlkKTsKCWZkID0gb3Blbihw
YXRoLCBPX1JEV1IgfCBPX0NSRUFULCAwNjAwKTsKCWlmIChmZCA8IDApCgkJcmV0dXJuIE5VTEw7
CgoJd2hpbGUgKCFzdG9wKSB7CgkJb2ZmX3Qgc2l6ZV9pbnNpZGVfZm9saW8gPSA0MDk2ICsgNDAw
ICsgKG9mZl90KShyb3VuZCAlIDYwMCk7CgkJc2l6ZV90IHNvdXJjZV9vZmZzZXQgPSAzMDAwICsg
KHJvdW5kICUgMTAwMCk7CgkJb2ZmX3Qgd3JpdGVfcG9zID0gNDA5NiArIDE1MDAgKyAob2ZmX3Qp
KHJvdW5kICUgMjAwMCk7CgoJCWZ0cnVuY2F0ZShmZCwgMCk7CgkJZnRydW5jYXRlKGZkLCBzaXpl
X2luc2lkZV9mb2xpbyk7CgkJLyogd3JpdGUoMiksIG5vdCBwd3JpdGUoMik6IHRoZSByZXBvcnRl
ZCB0cmFjZSBlbnRlcnMgdGhyb3VnaAoJCSAqIG5ld19zeW5jX3dyaXRlKCkva3N5c193cml0ZSgp
LiAqLwoJCWxzZWVrKGZkLCB3cml0ZV9wb3MsIFNFRUtfU0VUKTsKCQl3cml0ZShmZCwgc2hvcnRf
Y29weV9zb3VyY2UgKyBzb3VyY2Vfb2Zmc2V0LCAweDIwMDAwKTsKCQlyb3VuZCsrOwoJfQoJY2xv
c2UoZmQpOwoJcmV0dXJuIE5VTEw7Cn0KCi8qIEtlZXAgamJkMiBjeWNsaW5nIHNvIGEgdHJhbnNh
Y3Rpb24gaXMgaW4gdGhlIGNvbW1pdHRpbmcgc3RhdGUuICovCnN0YXRpYyB2b2lkICpmc3luY2Vy
KHZvaWQgKmFyZykKewoJbG9uZyBpZCA9IChsb25nKWFyZzsKCWNoYXIgcGF0aFs2NF0sIGJ1Zls1
MTJdOwoJaW50IGZkOwoKCW1lbXNldChidWYsICdjJywgc2l6ZW9mKGJ1ZikpOwoJc25wcmludGYo
cGF0aCwgc2l6ZW9mKHBhdGgpLCBNT1VOVFBPSU5UICIvcyVsZCIsIGlkKTsKCWZkID0gb3Blbihw
YXRoLCBPX1JEV1IgfCBPX0NSRUFULCAwNjAwKTsKCWlmIChmZCA8IDApCgkJcmV0dXJuIE5VTEw7
Cgl3aGlsZSAoIXN0b3ApIHsKCQlwd3JpdGUoZmQsIGJ1Ziwgc2l6ZW9mKGJ1ZiksIDApOwoJCWZz
eW5jKGZkKTsKCX0KCWNsb3NlKGZkKTsKCXJldHVybiBOVUxMOwp9CgppbnQgbWFpbih2b2lkKQp7
CglwdGhyZWFkX3QgdGhyZWFkc1tOUl9XUklURVJTICsgTlJfRlNZTkNFUlNdOwoJbG9uZyBpOwoK
CXNob3J0X2NvcHlfc291cmNlID0gbW1hcChOVUxMLCAzICogNDA5NiwgUFJPVF9SRUFEIHwgUFJP
VF9XUklURSwKCQkJCSBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsKCWlmIChz
aG9ydF9jb3B5X3NvdXJjZSA9PSBNQVBfRkFJTEVEKQoJCXJldHVybiAxOwoJbWVtc2V0KHNob3J0
X2NvcHlfc291cmNlLCAnQScsIDMgKiA0MDk2KTsKCW1wcm90ZWN0KHNob3J0X2NvcHlfc291cmNl
ICsgNDA5NiwgMiAqIDQwOTYsIFBST1RfTk9ORSk7CgoJdW5saW5rKElNQUdFKTsKCWlmIChzeXN0
ZW0oImRkIGlmPS9kZXYvemVybyBvZj0iIElNQUdFICIgYnM9MU0gY291bnQ9MTYwIHN0YXR1cz1u
b25lIikpCgkJcmV0dXJuIDE7CglpZiAoc3lzdGVtKCJta2ZzLmV4dDQgLXEgLUYgLWIgMTAyNCAt
SiBzaXplPTE2IC1JIDI1NiAiIElNQUdFKSkKCQlyZXR1cm4gMTsKCW1rZGlyKE1PVU5UUE9JTlQs
IDA3NTUpOwoJaWYgKHN5c3RlbSgibW91bnQgLXQgZXh0NCAtbyBsb29wLGRhdGE9am91cm5hbCxj
b21taXQ9MSAiCgkJICAgSU1BR0UgIiAiIE1PVU5UUE9JTlQpKQoJCXJldHVybiAxOwoKCWZvciAo
aSA9IDA7IGkgPCBOUl9XUklURVJTOyBpKyspCgkJcHRocmVhZF9jcmVhdGUoJnRocmVhZHNbaV0s
IE5VTEwsIHBhcnRpYWxfd3JpdGVyLCAodm9pZCAqKWkpOwoJZm9yIChpID0gMDsgaSA8IE5SX0ZT
WU5DRVJTOyBpKyspCgkJcHRocmVhZF9jcmVhdGUoJnRocmVhZHNbTlJfV1JJVEVSUyArIGldLCBO
VUxMLCBmc3luY2VyLCAodm9pZCAqKWkpOwoKCXNsZWVwKDQyKTsKCXN0b3AgPSAxOwoJZm9yIChp
ID0gMDsgaSA8IE5SX1dSSVRFUlMgKyBOUl9GU1lOQ0VSUzsgaSsrKQoJCXB0aHJlYWRfam9pbih0
aHJlYWRzW2ldLCBOVUxMKTsKCglzeXN0ZW0oInVtb3VudCAiIE1PVU5UUE9JTlQgIiAyPi9kZXYv
bnVsbCIpOwoJcmV0dXJuIDA7Cn0K
--000000000000f86613065af0ec65--
