Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458C31328C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849015; cv=none; b=GOpR5CISBJ3ns/NG4B+BM76CswYx/esHoHSfHTmejOSWHXHg5pf+UTAv9AaOkULuXaJK1DcggyX4YhiR67pG/t9leKimTxxFH+1qfNzIqXOiIZ6AqeiHNlSK3J+GLnu4BOM+cKafKoBgdPF392/+3CfkftoTumz5LI5Vgx/9NEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849015; c=relaxed/simple;
	bh=PlnqEm/DZ/8dV3iriRuwdaU9/9yoCQFqlta0/hmzjuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPPoi/oSBgqxzMA5RuCKZCS0JhNtC0n8BJOGrns2ZgG1wprE4yjI/yCG80Phb6NgLwhEMBcxX0ybtnUR+hC6q3qCPYBDocHzq9WCuj/0gTQbh3Rs4HOm8KPgOI7cKx1R7EDjUCJ1dEeHR2bu0i47TRnA4kV65hpxwPsDIXG5p9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ChmNS/3L; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ChmNS/3L"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b98069e41b0so97487966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773849010; x=1774453810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hyH5m1zGpGc64bdJRzjSRtU/WjkDb+Yk4KGtssaZXmE=;
        b=ChmNS/3LuqClv8QN4ZdlTIZ/1tkcHMNAkrkaYRz6cutEQpLTrEoA68Hse+UTRnl90v
         EDiTCvPC2w85RQvXN9b8TP9RQ4Ao4BY0+PgEeHaMiH507/9CG6tVmsWBnClDifgODtG+
         DBZQRronzT/GBC4m4Ou8+BCpCTczXGwbcFRHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773849010; x=1774453810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyH5m1zGpGc64bdJRzjSRtU/WjkDb+Yk4KGtssaZXmE=;
        b=d6D/8DI+JImLxTQ5RFMD7e8y1jFFxfRSvicHPLdXi8NAKMFMnzfE/wdaV2mtLbS561
         hKSgeNQfNyFYTwBr2kdyE0GzRs12kmHse3wxqPAaKXHKbjAHgYAbBNOvPMQxAoVtVDOh
         81WYzkIF8axpb3ET+LSsPd8Ur3Gacv3ora2lEu+MUinIrzP2HW1N2X8GuKX7MiZ6xwF9
         SK8J27ORuAdXAZNolHE/7ZiaxDOToIJdy6ur2Jq39mYvDBdZAVe52bjM0c619PnuO5xM
         8PvwP+bCvglPgVyQAsnAcUlxx8v6jirH6TEub9EVxUgVTgHqbXWqpvlXUES42LkrFK2O
         EBWw==
X-Forwarded-Encrypted: i=1; AJvYcCWImuNV01U2CjSy8bKl9/AfA9LH+J4s9/h+AO77pWPewY+MxSZ/Bp3+XW+2QgAz4kuXBglgeek5hVdpDGOm@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHqJtgkwabcXakqYjMJoq8Ig6oizh/NUkx7LJTVeURRVSooop
	8ObahfOrdujm24ExvW0xXa0+IzIw+yk+oUhftBRyWZY9+9x0T5J3cnb9JjcmOBEbVunUQZ+Tpdf
	qLdLfyPM=
X-Gm-Gg: ATEYQzwhN9Cvpjlzoh91Qgr6gMJz4dR4YfBTVEvt9d4rj+Rhq387m1PHoz6NA4Q2B5n
	z+DzHcrfYIl7OQgD06ibXo2wldjY3AAKLIUMiSU8EFfxDabQBFM9T3DYQ4o8rgl7/XrQ3zwfFML
	+UR+s8KtVG0/n4W/x9qIbh+IWjh3Mz9Dm74zxfiPCd9GVZQmWPNwOqowJ+OezXnWeoHBxSH3A9F
	eiBWXGk4hBbeYN7wId0JrtSjXx+L1QePdLnJfv4ScwF4T8BfDWs48D6jvmbJpuubj3QxoXZQAjN
	sm56bHD9Rsk2aSXpF/YN7f4GHrhHp0wKDopClRLC9isvonqtt343/BAdnmD8mfC/667CL+MB6+r
	BgpPAGXwH30sWPxYEb2aBIvosx7NrpelR5JSv8YQsblcprS0HKQYknGMbP9APaQUnN14dMcml1q
	23wJfvmsGBoNwPwnD71qGMJ1cYFqGG+P4opPxfTTyTsVDtz0z9X3/UyCbUyyxbG+Pk4nKqs7cB
X-Received: by 2002:a17:906:c102:b0:b96:f4f6:2a02 with SMTP id a640c23a62f3a-b980faad336mr5066866b.25.1773849010044;
        Wed, 18 Mar 2026 08:50:10 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667b129c335sm1996691a12.23.2026.03.18.08.50.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 08:50:08 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-666f73217baso2352491a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 08:50:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVo8g9f6/I7KS3lrmwZBBp6YI/Eq94W1K97smma2LwU4BDg+AXtAi0UtdsM+XKki/JP1O5cxywFspMb29N7@vger.kernel.org
X-Received: by 2002:a05:6402:270a:b0:666:f731:ea20 with SMTP id
 4fb4d7f45d1cf-66850ba75a6mr79140a12.1.1773849008014; Wed, 18 Mar 2026
 08:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23f19c88e763beb852a4891b2a908890bdd01b66.1773651096.git.chleroy@kernel.org>
 <CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com> <e19d7d3f-d2f3-4bb0-be4d-af2679673f68@kernel.org>
In-Reply-To: <e19d7d3f-d2f3-4bb0-be4d-af2679673f68@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Mar 2026 08:49:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJVSCmiQAQYYjdQqo9Z1k7WQcep2qW+DiqHyP7Y1_SnQ@mail.gmail.com>
X-Gm-Features: AaiRm53fbnxJ0qVvKDxvqCduKKdKPEASVF57GbRW7C6TLn-oqrl0EWkTjfSZIbo
Message-ID: <CAHk-=wiJVSCmiQAQYYjdQqo9Z1k7WQcep2qW+DiqHyP7Y1_SnQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs: Replace user_access_{begin/end} by scoped user access
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, David Laight <david.laight.linux@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000025589064d4e6831"

--000000000000025589064d4e6831
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 05:29, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> I went for a local var alternative, see v4. A helper would be of no help
> as the two patterns are not exactly the same:
>
>         size_t size = offsetof(struct old_linux_dirent, d_name) + namlen + 1;
>
>         size_t size = offsetof(struct compat_old_linux_dirent, d_name) + namlen + 1;

Your v4 looks fine to me, but admittedly a helper in the form of a
macro could have worked just fine:

    #define dirent_size(dirent, len) offsetof(typeof(dirent), d_name[len])

where I intentionally did *not* do the "+1", because some of our users
want to use "+2" because they put the d_type information in the byte
after the name (because they didn't have a 'd_type' field originally,
but did have the 'reclen' field).

Because we actually have that pattern more than two times, just in
different guises.

Something untested like the attached...

                     Linus

--000000000000025589064d4e6831
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mmw7vyc70>
X-Attachment-Id: f_mmw7vyc70

IGZzL3JlYWRkaXIuYyB8IDE5ICsrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3JlYWRkaXIu
YyBiL2ZzL3JlYWRkaXIuYwppbmRleCA3MzcwN2I2ODE2ZTkuLmRkZDJmMjhlNTI3OCAxMDA2NDQK
LS0tIGEvZnMvcmVhZGRpci5jCisrKyBiL2ZzL3JlYWRkaXIuYwpAQCAtMjIsNiArMjIsOCBAQAog
I2luY2x1ZGUgPGxpbnV4L2NvbXBhdC5oPgogI2luY2x1ZGUgPGxpbnV4L3VhY2Nlc3MuaD4KIAor
I2RlZmluZSBkaXJlbnRfc2l6ZShkaXJlbnQsIGxlbikgb2Zmc2V0b2YodHlwZW9mKCooZGlyZW50
KSksIGRfbmFtZVtsZW5dKQorCiAvKgogICogU29tZSBmaWxlc3lzdGVtcyB3ZXJlIG5ldmVyIGNv
bnZlcnRlZCB0byAnLT5pdGVyYXRlX3NoYXJlZCgpJwogICogYW5kIHRoZWlyIGRpcmVjdG9yeSBp
dGVyYXRvcnMgd2FudCB0aGUgaW5vZGUgbG9jayBoZWxkIGZvcgpAQCAtMTk4LDkgKzIwMCw3IEBA
IHN0YXRpYyBib29sIGZpbGxvbmVkaXIoc3RydWN0IGRpcl9jb250ZXh0ICpjdHgsIGNvbnN0IGNo
YXIgKm5hbWUsIGludCBuYW1sZW4sCiAJfQogCWJ1Zi0+cmVzdWx0Kys7CiAJZGlyZW50ID0gYnVm
LT5kaXJlbnQ7Ci0JaWYgKCF1c2VyX3dyaXRlX2FjY2Vzc19iZWdpbihkaXJlbnQsCi0JCQkodW5z
aWduZWQgbG9uZykoZGlyZW50LT5kX25hbWUgKyBuYW1sZW4gKyAxKSAtCi0JCQkJKHVuc2lnbmVk
IGxvbmcpZGlyZW50KSkKKwlpZiAoIXVzZXJfd3JpdGVfYWNjZXNzX2JlZ2luKGRpcmVudCwgZGly
ZW50X3NpemUoZGlyZW50LCBuYW1sZW4rMSkpKQogCQlnb3RvIGVmYXVsdDsKIAl1bnNhZmVfcHV0
X3VzZXIoZF9pbm8sICZkaXJlbnQtPmRfaW5vLCBlZmF1bHRfZW5kKTsKIAl1bnNhZmVfcHV0X3Vz
ZXIob2Zmc2V0LCAmZGlyZW50LT5kX29mZnNldCwgZWZhdWx0X2VuZCk7CkBAIC0yNjMsOCArMjYz
LDcgQEAgc3RhdGljIGJvb2wgZmlsbGRpcihzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCwgY29uc3Qg
Y2hhciAqbmFtZSwgaW50IG5hbWxlbiwKIAlzdHJ1Y3QgZ2V0ZGVudHNfY2FsbGJhY2sgKmJ1ZiA9
CiAJCWNvbnRhaW5lcl9vZihjdHgsIHN0cnVjdCBnZXRkZW50c19jYWxsYmFjaywgY3R4KTsKIAl1
bnNpZ25lZCBsb25nIGRfaW5vOwotCWludCByZWNsZW4gPSBBTElHTihvZmZzZXRvZihzdHJ1Y3Qg
bGludXhfZGlyZW50LCBkX25hbWUpICsgbmFtbGVuICsgMiwKLQkJc2l6ZW9mKGxvbmcpKTsKKwlp
bnQgcmVjbGVuID0gQUxJR04oZGlyZW50X3NpemUoZGlyZW50LCBuYW1sZW4rMiksIHNpemVvZihs
b25nKSk7CiAJaW50IHByZXZfcmVjbGVuOwogCXVuc2lnbmVkIGludCBmbGFncyA9IGRfdHlwZTsK
IApAQCAtMzUyLDggKzM1MSw3IEBAIHN0YXRpYyBib29sIGZpbGxkaXI2NChzdHJ1Y3QgZGlyX2Nv
bnRleHQgKmN0eCwgY29uc3QgY2hhciAqbmFtZSwgaW50IG5hbWxlbiwKIAlzdHJ1Y3QgbGludXhf
ZGlyZW50NjQgX191c2VyICpkaXJlbnQsICpwcmV2OwogCXN0cnVjdCBnZXRkZW50c19jYWxsYmFj
azY0ICpidWYgPQogCQljb250YWluZXJfb2YoY3R4LCBzdHJ1Y3QgZ2V0ZGVudHNfY2FsbGJhY2s2
NCwgY3R4KTsKLQlpbnQgcmVjbGVuID0gQUxJR04ob2Zmc2V0b2Yoc3RydWN0IGxpbnV4X2RpcmVu
dDY0LCBkX25hbWUpICsgbmFtbGVuICsgMSwKLQkJc2l6ZW9mKHU2NCkpOworCWludCByZWNsZW4g
PSBBTElHTihkaXJlbnRfc2l6ZShkaXJlbnQsIG5hbWxlbisxKSwgc2l6ZW9mKHU2NCkpOwogCWlu
dCBwcmV2X3JlY2xlbjsKIAl1bnNpZ25lZCBpbnQgZmxhZ3MgPSBkX3R5cGU7CiAKQEAgLTQ2MCw5
ICs0NTgsNyBAQCBzdGF0aWMgYm9vbCBjb21wYXRfZmlsbG9uZWRpcihzdHJ1Y3QgZGlyX2NvbnRl
eHQgKmN0eCwgY29uc3QgY2hhciAqbmFtZSwKIAl9CiAJYnVmLT5yZXN1bHQrKzsKIAlkaXJlbnQg
PSBidWYtPmRpcmVudDsKLQlpZiAoIXVzZXJfd3JpdGVfYWNjZXNzX2JlZ2luKGRpcmVudCwKLQkJ
CSh1bnNpZ25lZCBsb25nKShkaXJlbnQtPmRfbmFtZSArIG5hbWxlbiArIDEpIC0KLQkJCQkodW5z
aWduZWQgbG9uZylkaXJlbnQpKQorCWlmICghdXNlcl93cml0ZV9hY2Nlc3NfYmVnaW4oZGlyZW50
LCBkaXJlbnRfc2l6ZShkaXJlbnQsIG5hbWxlbisxKSkpCiAJCWdvdG8gZWZhdWx0OwogCXVuc2Fm
ZV9wdXRfdXNlcihkX2lubywgJmRpcmVudC0+ZF9pbm8sIGVmYXVsdF9lbmQpOwogCXVuc2FmZV9w
dXRfdXNlcihvZmZzZXQsICZkaXJlbnQtPmRfb2Zmc2V0LCBlZmF1bHRfZW5kKTsKQEAgLTUxOSw4
ICs1MTUsNyBAQCBzdGF0aWMgYm9vbCBjb21wYXRfZmlsbGRpcihzdHJ1Y3QgZGlyX2NvbnRleHQg
KmN0eCwgY29uc3QgY2hhciAqbmFtZSwgaW50IG5hbWxlbgogCXN0cnVjdCBjb21wYXRfZ2V0ZGVu
dHNfY2FsbGJhY2sgKmJ1ZiA9CiAJCWNvbnRhaW5lcl9vZihjdHgsIHN0cnVjdCBjb21wYXRfZ2V0
ZGVudHNfY2FsbGJhY2ssIGN0eCk7CiAJY29tcGF0X3Vsb25nX3QgZF9pbm87Ci0JaW50IHJlY2xl
biA9IEFMSUdOKG9mZnNldG9mKHN0cnVjdCBjb21wYXRfbGludXhfZGlyZW50LCBkX25hbWUpICsK
LQkJbmFtbGVuICsgMiwgc2l6ZW9mKGNvbXBhdF9sb25nX3QpKTsKKwlpbnQgcmVjbGVuID0gQUxJ
R04oZGlyZW50X3NpemUoZGlyZW50LCBuYW1sZW4rMiksIHNpemVvZihjb21wYXRfbG9uZ190KSk7
CiAJaW50IHByZXZfcmVjbGVuOwogCXVuc2lnbmVkIGludCBmbGFncyA9IGRfdHlwZTsKIAo=
--000000000000025589064d4e6831--
