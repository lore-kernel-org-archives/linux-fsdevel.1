Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793380397;
	b=AX6MEvjNvcEfZFX07WlbEp6kXIjwXVcufxj0XutQL3AfvY779v0Hhwa/ZfRp006y/8NK
	 OPDMJmDI5ypvaO1r2++pDs5/nzjfn8Zy9jAHKsNOIxuLmkg2fIAv9Vqj86wIJZkL4oFlu
	 hu6uXA5NABWC9Efebc/Jc/A7O2eS5SBvmjmY05JZGXbGVNjwF1IhMPwH/svhHWzBZ4WvC
	 uhrPBHzps2uQNAeM0IOPaz92lqUqMmzFepdniMXw6ybyBGjoF3HcLwPXAR52id4oXrL0/
	 UJ0ynv+VogFiqMof1kIKoRpe7+x+NDkK/H80DD/yo5keW+z6Q2vBzBKCHc1ovPWg+iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=E3gG5rlfUk6JdnmcJYvWieSL2F3qD4lVlhHKMd1orkk=;
	b=2VUjdrxRiYOZoE4Hp6cPpOwJyd/Osd5s4NR+POjlZNyYpAmsYkkU+kL0AdcFgCrSgeSn
	 RVABVnzgfO3F09VyO34N3+oqWJg2BRJWkebk0uCTBPj3FJCWm2WyUQfOAi+FyPdImWwT1
	 jihVvIt/3YVuJlrnrWBYHuTEZKnvfFnoBuT0fisLUKtzxtREpQtjJNFGn0liFDBXn/vVF
	 9K04Vg1rYKD3+47LnQKx8UYEOQvo9ALGahw1tQgifBkTTqC4d0Dq3dsbGXH5RaZdRRM+5
	 s2IkL4ynjBAisCPZ7Ihug/tie94aflgGY4IelNT1TMsh8ay0su9Sd0vgxLWA2mGqbHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifDw+EdI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FB606A31F
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 17:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E52FB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifDw+EdI
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c43fbcb4393so150005166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 10:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793380395; cv=none;
        d=google.com; s=arc-20260327;
        b=FTp76cetYGP9YUdnjPW9ce6nqqZGB8Aevv+ZeB/W858aQtq4XqaobKFrBbN1K7x7GI
         RRiccrq6cp8Qhe7PoxMTp1PHkhL7AYf3fMzQjz1auaxb+M3/AoUahe6piOdIipGUhlar
         HmPjCatM/Dn6d94AXaE5maAjo6oyF09oeZfTEHS2QX4ZCwqxaYXI41nHYA0xc6Me97i+
         tl706ZK0bKLqUDA9J2mrK6GLawjLdD8FJqqE8MX+6FRe9c+Y/IBaLwHUN23iU0VwUpst
         NsIo/9Pt5GMtBrrVCVBTmOIc3B3wWc0iRnXC3bBCWesKiq0yjKrt87kbyKwht3RZ3aHP
         phuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E3gG5rlfUk6JdnmcJYvWieSL2F3qD4lVlhHKMd1orkk=;
        fh=XSkYG8U1/KLvc+aWC11SxKNaiozhip6XBb1txFr71hk=;
        b=fwhVXPssffuPJhHs51KHmDO+s4xAeuWVAU+DARL5VzdhhS9shIokU1DEF56hqfFoRc
         J/EbUOQ9curK1qqRNzcrSa0kwq8f5WuIUomBPuTQgEg4No0gT+0e39EMEseW7aagg9Eh
         ZHHQlkrWZdJCzIuh4Jl5lXlA07b7Dy+D8HJegjVTceJKjCFeZb6v8Gtljx0ANI5924OL
         ZtT8XL4tBaH5hZbs4SztAiepH629fInQm4t1ElZKY7ETfQl4UvAwI17RdppvONRqjjd3
         lYcI+plzpmdEX+cijTw2cQkduXmNYYM655bP/ACVJcwl6ySE9VgwTfRSP8aGetJzy/GM
         uADA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380395; x=1793985195; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3gG5rlfUk6JdnmcJYvWieSL2F3qD4lVlhHKMd1orkk=;
        b=ifDw+EdIe+epQJ7z53+pvytV/Bz9e1dka8Di3d8b+CcNla0YYnpduqr3e3sLyOWLMZ
         wHXQ1imrTC/MPWq8CBnOsyUS/WN/MLcGkGNx7PM2xV5/Ib0JyCF4LPE+7b2I95rEI1or
         PSerFeC7d1MjpwS29FgRMkrx9te1JAGuY49v6aA3LEcWbwSnm0crQ4LdimC33bdiXfDL
         wCSyODExZ2G0jDQ+98o4285TFFxnEYFPII1HMCh8mBcwgapTM87LIxyBlBFyow2jhPch
         3O2tqTRpWVbhpK9Bo/MyyiHiqT91+VKH8DpBEmCh41VTEb3l7PsXNHPdebuKkF55bpol
         xiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380395; x=1793985195;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E3gG5rlfUk6JdnmcJYvWieSL2F3qD4lVlhHKMd1orkk=;
        b=K5uHFl2vbYlxlS/dYAI47HPNQaLnCqZohkuHVeBLWgP2hBLfwkM0QR6QEiybGLplB0
         gcyDx7a5mvdpCSDyGn+QWNnlj8dtQPkqmpb9Ch3+RR1pafMJpix/fFlEHZIrva1oYx4M
         YEBdT8DUx+ZxDcpPkWz8Dkyc/0fdWR9ZKwooGk570pF17SOMfkPu1Dl6uxzc1TLeVCFV
         Tm/rrqYN7VIQn+JL7sFrE+ZnbZfIchN6Zs4vJOa91VeXuS8uGajSW8wFly6KraoLSJDS
         FEDi8cnbTPQ+cruN4penVH72Ux0FTvx1y9dfk1AZLi9/t0OA7IngJik60RQxhRGUzmtD
         GuZg==
X-Forwarded-Encrypted: i=1; AKwUvBx4N5J+PLAuir6mHNKJtBcG5UJJdN4w5zh5GBgnUiWwmKuAQ8u9lhVGXJ8oq3anjiskP1guSnvOK1WgKN8H@vger.kernel.org
X-Gm-Message-State: AFq9FYIXpyEsp5OqLxF6k6f+LvNLYpK3OZsWnrXbeph71hk31DNdXbJP
	oa7UP3oBhOei2ZUrwnKjyC72sM8yXsv/ykzZ6UoGARA/tdcm0ggOyC9Pv91DIOKIgKowNDEIvYH
	4zicKZsok541YARGXOH+IqGvy19y9deQ=
X-Gm-Gg: AYBFou031J/qqxf/wnaZZX2i24G90ABctzB+dn5p5XM6lIk4HsIRS7LVpFt3qGIGf8A
	tt3GTrIiCDs8wTent/F7fbhTxmb+NlMSY5Mf9qQgiCXNPs5BuUwpIg8FgO9N/vcVUpMFUpo2Dws
	l2bfdA8q5hS9Ibp8uPE3nAiYPdL0LmP6hi0ZzeRTlZnkbwTaYyeTZgcXzuyXmVAy++/Mn0rewtB
	yfr/4M+B4YmJ5vkLMM6x6ceRAnF9QWEJIQuOXdJWtQntb5EFwVHnwrdKHSCwAfe5j/8tmuhNSEY
	x5Kd/jDmFqFbUNLk+wigmL4Kt8U6Fa9ce3+BNvZ7gPLGnhBJJzJpxsCx/y1J6wrHJaTQU0Ee0TO
	OWcVxtlrPxqN4JVxxeanfw6v/Xtt7BxtXyLj75CO7+qrXjac+7YMj9mKV9VCaMbW6GgpeDg==
X-Received: by 2002:a17:907:9621:b0:c46:d493:501a with SMTP id
 a640c23a62f3a-c4ca7a4f162mr288456766b.22.1793380394999; Fri, 30 Oct 2026
 10:13:14 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <P58Wrer--F-9@tuta.io> <20261030-welpen-anbinden-nullen-b2432cee1d10@brauner>
In-Reply-To: <20261030-welpen-anbinden-nullen-b2432cee1d10@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 18:13:02 +0100
X-Gm-Features: AclHuK9oWOrrGn0HCF_l2TtwxZH_Qc4ggZ1PaI8aHfzRvMrzHwkJXs8-TFfiX0o
Message-ID: <CAOQ4uxjm=cGPnug18VuhKqiMvkWwLPNLO_TE3KxO8iLZG+veYQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs: let backing files inherit FMODE_NONOTIFY from the
 user file
To: Christian Brauner <brauner@kernel.org>, Edvard Conrad <edvard@tuta.io>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000647aac065f11e915"

--000000000000647aac065f11e915
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 3:57=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Oct 29, 2026 at 10:18:40PM +0100, Edvard Conrad wrote:
> > Make a backing file inherit FMODE_NONOTIFY when the user file it is
> > opened for must not generate events. This restores the pre-6.14
> > behaviour for the fds that fanotify creates (and for any other
> > FMODE_NONOTIFY file), while ordinary opens through a stacked filesystem
> > keep generating events on the real path, as intended by bc2473c90fca.
>
> Looks good to me. I'll take this via vfs.fixes and fix up the subject to
> use the "backing-file:" prefix while applying.
>
> Amir, note that the same deadlock is still there for directories.
> ovl_dir_open_realfile() goes through ovl_path_open() -> dentry_open()
> and not through backing_file_open(). So a FAN_OPEN_PERM|FAN_ONDIR
> listener that opens an overlay directory through the fd fanotify handed
> it wedges the same way. That needs to be fixed on the overlayfs side.

Urgh! for f sake, can we just bring back the damn Kludge?!%$

Edvard,

Would you mind adding test cases (or variants) to fanotify26 to cover this =
find
and test the attached (sanity tested only) patch.

No need to hold off on the merge, you can post another patch to
add the test cases.

Thanks,
Amir.

--000000000000647aac065f11e915
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ovl-inherit-FMODE_NONOTIFY-when-opening-directory-re.patch"
Content-Disposition: attachment; 
	filename="0001-ovl-inherit-FMODE_NONOTIFY-when-opening-directory-re.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvv8a5ti0>
X-Attachment-Id: f_mvv8a5ti0

RnJvbSBhZTBlMzU4NGZlOWMzMjA0MDg4OTI3MWIzZWNlYzQ1ODAxMjNhNWNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDMwIE9jdCAyMDI2IDE4OjA3OjAyICswMTAwClN1YmplY3Q6IFtQQVRDSF0gb3Zs
OiBpbmhlcml0IEZNT0RFX05PTk9USUZZIHdoZW4gb3BlbmluZyBkaXJlY3RvcnkgcmVhbGZpbGVz
CgpXaGVuIGZhbm90aWZ5IGhhbmRzIGEgbGlzdGVuZXIgYW4gZmQgZm9yIGEgcGVybWlzc2lvbiBl
dmVudCBvbiBhbgpvdmVybGF5IGRpcmVjdG9yeSwgb3ZsX2Rpcl9vcGVuX3JlYWxmaWxlKCkgb3Bl
bnMgdGhlIHJlYWwgZGlyZWN0b3J5IHZpYQpkZW50cnlfb3BlbigpLCBub3QgYmFja2luZ19maWxl
X29wZW4oKSwgc28gdGhlIGxvd2VyIG9wZW4gY291bGQgc3RpbGwKcmFpc2UgRlNfT1BFTl9QRVJN
IGFuZCBkZWFkbG9jayBhIGxpc3RlbmVyIHRoYXQgYWxzbyBtYXJrcyB0aGUgYmFja2luZwpmaWxl
c3lzdGVtLgoKRXhwb3J0IGRlbnRyeV9vcGVuX25vbm90aWZ5KCkgYW5kIGNhbGwgaXQgZnJvbSBv
dmxfcGF0aF9vcGVuX3JlYWxmaWxlKCkKd2hlbiB0aGUgb3ZlcmxheSB1c2VyIGZpbGUgbXVzdCBu
b3QgZ2VuZXJhdGUgZXZlbnRzLiAgT3JkaW5hcnkKb3ZsX3BhdGhfb3BlbigpIGNhbGxlcnMgYXJl
IHVuY2hhbmdlZC4KClJlcG9ydGVkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAoQW11dGFibGUpIDxi
cmF1bmVyQGtlcm5lbC5vcmc+CkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjYxMDMwLXdlbHBlbi1hbmJpbmRlbi1udWxsZW4tYjI0MzJjZWUxZDEwQGJyYXVuZXIvCkZpeGVz
OiBlYmU1NTk2MDlkNzggKCJmczogZ2V0IHJpZCBvZiBfX0ZNT0RFX05PTk9USUZZIGtsdWRnZSIp
CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWlu
IDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvb3Blbi5jICAgICAgICAgICAgICAgIHwgIDEg
KwogZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oIHwgIDkgKysrKysrKystCiBmcy9vdmVybGF5ZnMv
cmVhZGRpci5jICAgfCAgMyArKy0KIGZzL292ZXJsYXlmcy91dGlsLmMgICAgICB8IDExICsrKysr
KysrKystCiA0IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvb3Blbi5jIGIvZnMvb3Blbi5jCmluZGV4IDZiMWMxNGU2ODRhOTMu
LmQ3ZDlmY2M2NjZhYjUgMTAwNjQ0Ci0tLSBhL2ZzL29wZW4uYworKysgYi9mcy9vcGVuLmMKQEAg
LTExNDcsNiArMTE0Nyw3IEBAIHN0cnVjdCBmaWxlICpkZW50cnlfb3Blbl9ub25vdGlmeShjb25z
dCBzdHJ1Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzLAogCX0KIAlyZXR1cm4gZjsKIH0KK0VYUE9S
VF9TWU1CT0xfR1BMKGRlbnRyeV9vcGVuX25vbm90aWZ5KTsKIAogLyoqCiAgKiBrZXJuZWxfZmls
ZV9vcGVuIC0gb3BlbiBhIGZpbGUgZm9yIGtlcm5lbCBpbnRlcm5hbCB1c2UKZGlmZiAtLWdpdCBh
L2ZzL292ZXJsYXlmcy9vdmVybGF5ZnMuaCBiL2ZzL292ZXJsYXlmcy9vdmVybGF5ZnMuaAppbmRl
eCA0ZmFlYmI0YzY4MjViLi5iMzIwODlhMTA0MjkxIDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMv
b3ZlcmxheWZzLmgKKysrIGIvZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oCkBAIC01MjksNyArNTI5
LDE0IEBAIHZvaWQgb3ZsX2Rpcl9tb2RpZmllZChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGJvb2wg
aW1wdXJpdHkpOwogdTY0IG92bF9pbm9kZV92ZXJzaW9uX2dldChzdHJ1Y3QgaW5vZGUgKmlub2Rl
KTsKIGJvb2wgb3ZsX2lzX3doaXRlb3V0KHN0cnVjdCBkZW50cnkgKmRlbnRyeSk7CiBib29sIG92
bF9wYXRoX2lzX3doaXRlb3V0KHN0cnVjdCBvdmxfZnMgKm9mcywgY29uc3Qgc3RydWN0IHBhdGgg
KnBhdGgpOwotc3RydWN0IGZpbGUgKm92bF9wYXRoX29wZW4oY29uc3Qgc3RydWN0IHBhdGggKnBh
dGgsIGludCBmbGFncyk7CitzdHJ1Y3QgZmlsZSAqb3ZsX3BhdGhfb3Blbl9yZWFsZmlsZShjb25z
dCBzdHJ1Y3QgZmlsZSAqdXNlcl9maWxlLAorCQkJCSAgICBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0
aCwgaW50IGZsYWdzKTsKKworc3RhdGljIGlubGluZSBzdHJ1Y3QgZmlsZSAqb3ZsX3BhdGhfb3Bl
bihjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzKQoreworCXJldHVybiBvdmxfcGF0
aF9vcGVuX3JlYWxmaWxlKE5VTEwsIHBhdGgsIGZsYWdzKTsKK30KKwogaW50IG92bF9jb3B5X3Vw
X3N0YXJ0KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgaW50IGZsYWdzKTsKIHZvaWQgb3ZsX2NvcHlf
dXBfZW5kKHN0cnVjdCBkZW50cnkgKmRlbnRyeSk7CiBib29sIG92bF9hbHJlYWR5X2NvcGllZF91
cChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIGludCBmbGFncyk7CmRpZmYgLS1naXQgYS9mcy9vdmVy
bGF5ZnMvcmVhZGRpci5jIGIvZnMvb3ZlcmxheWZzL3JlYWRkaXIuYwppbmRleCBiODYyMzA5ZWJh
NGQxLi41ZDIxYTMyOGZhZDQ2IDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvcmVhZGRpci5jCisr
KyBiL2ZzL292ZXJsYXlmcy9yZWFkZGlyLmMKQEAgLTk5NCw3ICs5OTQsOCBAQCBzdGF0aWMgc3Ry
dWN0IGZpbGUgKm92bF9kaXJfb3Blbl9yZWFsZmlsZShjb25zdCBzdHJ1Y3QgZmlsZSAqZmlsZSwK
IAkJCQkJICBjb25zdCBzdHJ1Y3QgcGF0aCAqcmVhbHBhdGgpCiB7CiAJd2l0aF9vdmxfY3JlZHMo
ZmlsZV9pbm9kZShmaWxlKS0+aV9zYikKLQkJcmV0dXJuIG92bF9wYXRoX29wZW4ocmVhbHBhdGgs
IE9fUkRPTkxZIHwgKGZpbGUtPmZfZmxhZ3MgJiBPX0xBUkdFRklMRSkpOworCQlyZXR1cm4gb3Zs
X3BhdGhfb3Blbl9yZWFsZmlsZShmaWxlLCByZWFscGF0aCwKKwkJCQkJICAgICAgT19SRE9OTFkg
fCAoZmlsZS0+Zl9mbGFncyAmIE9fTEFSR0VGSUxFKSk7CiB9CiAKIC8qCmRpZmYgLS1naXQgYS9m
cy9vdmVybGF5ZnMvdXRpbC5jIGIvZnMvb3ZlcmxheWZzL3V0aWwuYwppbmRleCA0NzczNGVlYjk3
Yjc1Li4wNDEwM2E2NzQxYmEwIDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvdXRpbC5jCisrKyBi
L2ZzL292ZXJsYXlmcy91dGlsLmMKQEAgLTY1NCw3ICs2NTQsOCBAQCBib29sIG92bF9wYXRoX2lz
X3doaXRlb3V0KHN0cnVjdCBvdmxfZnMgKm9mcywgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgpCiAJ
CW92bF9wYXRoX2NoZWNrX3h3aGl0ZW91dF94YXR0cihvZnMsIHBhdGgpOwogfQogCi1zdHJ1Y3Qg
ZmlsZSAqb3ZsX3BhdGhfb3Blbihjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzKQor
c3RydWN0IGZpbGUgKm92bF9wYXRoX29wZW5fcmVhbGZpbGUoY29uc3Qgc3RydWN0IGZpbGUgKnVz
ZXJfZmlsZSwKKwkJCQkgICAgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIGludCBmbGFncykKIHsK
IAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZF9pbm9kZShwYXRoLT5kZW50cnkpOwogCXN0cnVjdCBt
bnRfaWRtYXAgKnJlYWxfaWRtYXAgPSBtbnRfaWRtYXAocGF0aC0+bW50KTsKQEAgLTY4Miw2ICs2
ODMsMTQgQEAgc3RydWN0IGZpbGUgKm92bF9wYXRoX29wZW4oY29uc3Qgc3RydWN0IHBhdGggKnBh
dGgsIGludCBmbGFncykKIAlpZiAoaW5vZGVfb3duZXJfb3JfY2FwYWJsZShyZWFsX2lkbWFwLCBp
bm9kZSkpCiAJCWZsYWdzIHw9IE9fTk9BVElNRTsKIAorCS8qCisJICogRGlyZWN0b3J5IG9wZW5z
IHVzZSBkZW50cnlfb3BlbigpIGhlcmUsIG5vdCBiYWNraW5nX2ZpbGVfb3BlbigpLgorCSAqIElu
aGVyaXQgRk1PREVfTk9OT1RJRlkgZnJvbSBhIGZhbm90aWZ5IHBlcm1pc3Npb24gZmQgc28gYSBs
aXN0ZW5lcgorCSAqIHRoYXQgYWxzbyB3YXRjaGVzIHRoZSByZWFsIGZpbGVzeXN0ZW0gZG9lcyBu
b3QgZGVhZGxvY2suCisJICovCisJaWYgKHVzZXJfZmlsZSAmJiBGTU9ERV9GU05PVElGWV9OT05F
KHVzZXJfZmlsZS0+Zl9tb2RlKSkKKwkJcmV0dXJuIGRlbnRyeV9vcGVuX25vbm90aWZ5KHBhdGgs
IGZsYWdzLCBjdXJyZW50X2NyZWQoKSk7CisKIAlyZXR1cm4gZGVudHJ5X29wZW4ocGF0aCwgZmxh
Z3MsIGN1cnJlbnRfY3JlZCgpKTsKIH0KIAotLSAKMi41NS4wCgo=
--000000000000647aac065f11e915--
