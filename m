Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012573;
	b=pYFV47IwyoT3A2L9dzts0Ve7qP9f+Ao9nmY6DhMm851lV4biJka4ey6PUEN4FMXTpxIv
	 BkRg8dYKztUL9+Wqghf53V4Iv3HcSCxvnVqeUVpSNnytfDWcchZ5wMPf04HuwFP0UOeC5
	 ORwiJ0rIBD4deXd1++UQqqaWYkvnx2erKz84Zpg85gA16X7+XbM5Ht78zS6LE0A85Z0l2
	 Pzdz6G6p2k0Ke1zqqd+yldcWZmACTqu6LRHESZfOmTlY8utyqjToHBYi9SlT2IpmLyDMW
	 yh7emri/R76/eU2p42p+jJBW1xVcg0k46T+bz3MOeQ6lhgMBs11WYW+yiG4odXzmwQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=3mcjCZlBFCK3BFU/pR9im1KSEOYOnqojx/QzlZU3dAw=;
	b=GwHZbQf/lheAL39cDvtT/hyQCFvJzLz4+0y8EdwfwGnKReoElYPyrwXKOh2iajMHBQfY
	 RSRllseKH2u+0Sg1piYxZfmtvOngstz5gH2nHLK5epaZBQVWm2zacQiGc11Q8uXJpwNNY
	 KIE3WNTs9Nq7foEkyCaQJucz6zJKeJiOWfKltwNEkHyX/qNwZvMs63i1TH4iwVNj0vjhf
	 LCTAF4uKKIIuUzI7O4PZKaARYcQqnBDqnpq4o5TvGu388ErhrhVEyYg+cv4szPHPc/S+L
	 Ta8WJ+RoYCfA3apbzq/pZbKzDiz6wTb78VJdOIoKQT+YlXeqNBZPcNPQ6wg751AOG9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nvRws8Dv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B43606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 11:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41B43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nvRws8Dv
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b28d7c729fso1491147b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 04:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793012572; cv=none;
        d=google.com; s=arc-20260327;
        b=nTtj51dL2IMmzJHANg4hW/j3qL62Y7WIc7s6zm8UyZZZviQvyrGksQmMTNMvx7HNjt
         U0dufm4QAwG+h7K4BrXGYbS9tIPSSYFLet4wor8CX/KkOVnmQ8zxWc6lvLQ7IDi50b/j
         uqi52IKZfqnOka0SF9h0HdaPmkQFZpTb1J1XGX0vpi1z8UXJ5/oCg2zMl5tKMSDDIk6j
         HPRA3vcIcWhokFCrec6uXqykOirBMVLy6Gk1reRMlaZvAv5wpGSftgxqQDiuExcvx/qc
         5W9SvuvhldiZUEhwcPJlqmhgSQ8ITlTmy1Csnx1Y9zhDqkKufIZ6QY0b5tBMzLkpbhAW
         DTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3mcjCZlBFCK3BFU/pR9im1KSEOYOnqojx/QzlZU3dAw=;
        fh=k4C1SfJFW4Ct/MEvbzPf5IZVE+DEnx8jGHacZQ+jlw0=;
        b=HPLVs+RMBxiOBftLqC3SKQSqhRb/G4mm6M3HmuuOqs4WwoEBUh/UkbEkAJcl9BexK1
         84wmGI4qG4wPo/Xv1D3HuZsg5v+ZSbLojJtWZPsYUP+wAS717varCjZZWrb2nUq0mVy8
         94nCcGhm+HYpER4yAwZXB8t+suMyLutbl0Q0R8c8cQU4Q2fY9dcl6kmjNuLUdaCSDdem
         UnuErUNUXtJDfBMPCGfTI/3MP6IFIv2pUVtpOLmb4+FAok5NbETtcwdbHSvAWwDMrtfI
         KZ264qdllUvbSfCSMuX1AsLj1fIHAmlWbIQzDlPbeIYpZKpvOodhyLsEziUKR94Cr/5D
         ugDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012572; x=1793617372; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3mcjCZlBFCK3BFU/pR9im1KSEOYOnqojx/QzlZU3dAw=;
        b=nvRws8DvMsW2AjQu2Dx/GUn5Jxpd520LVC/3t3DHSLhqPm5gGz6NzPW90OWlWkH/im
         f0arfdjmiBEUfvpY3bF/Nmz5nku24bPwvsvrZYhKshnP9vtnuEFx8CMqIUi9meuUYYaz
         pYu+PbFRqvrevX7HnaLUa4s+h5wWA7b+Kl197HGlqhddbBK75tGqFV+X7sxTKasqYF2p
         14DLejLIvUkBwZivrB8l4njNVcd1OYdaNCejypNum/LOX8gMqYa0kpFGJ81uPpu4pXoQ
         nWi2LlOWBleIwJpkQTWll2gq9drQNiY8rrotFGWfUscIvJeR8uqneGtCtJek/0mfYTg9
         jj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012572; x=1793617372;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3mcjCZlBFCK3BFU/pR9im1KSEOYOnqojx/QzlZU3dAw=;
        b=I5F/T+WigpMXuj/CRYnh1YtUCYxtkr5GFqVyY1Fkj+gw5QAAy87VsfTZ9IHbELMqSe
         hEvXW/2VWIPE24VUAegjWZZqRE6XQrIMulBf2nz4HcRaOTfx31iNKAlUu6PHNOKJv4U0
         VZeEwIy5pbwX8Om7keAAuMNitZC6jHQpHO9vbwi9vG6rYRMe9hfjHBx3XAfgS7Bt/7e5
         QC7w5CQVCZOQrA3VDzeSUvxmuM4MbYiNp8JH6xG/yTZ3Z89WOXFr8wLMoKm2SZORqwxx
         abLwpzwItML56mCM5uk2ZjcqwYSDjfv+dZMPe0OJVMNMsYDmWAKoTQad6VCbcsOYgsEp
         YU4g==
X-Gm-Message-State: AFq9FYJ0e9xMq8yKuhjaK39lbHcp2YT0FMfvSomPiOSj71HCOWK7LTmd
	RcXY1p7vZjCk9d+5GtPDfLz9POWj85M/V7MQ7hSlQrYAu55psg6mLN1YSRPaKjaq0kHX8l6Nc/W
	1Rsf8QGLThkP9miAjQrgP6p95vJ9QPqocON6hHEdcFC0pDN8=
X-Gm-Gg: AYBFou0nOM5rfGzM+O+FRUNN6k0XZinBQ/9vBYvS4epf6bbkh7/AFz1twfFFEd+slMP
	SARKlTf97xTfSeTmCr3nPXD/qEozhag5h7mq6xc7+uxIkT1RjH1ejb3NoWRUwNrechjfFsk79hc
	L4JAjp6JQ4IYiiCTjOE3YOQpE1yUeyQ7DAGlUcTlTbwFMZYnr6sur4k4P7xMWRyXSM8EJKEKFGg
	fe0Ce9haKGXnDiwO1SXsQ+9QRLzBWKwc5ID7c5swZ1cLLcslCGEXaBDxo1w/KVNiuZlc5HCjwIF
	kD7Dz6bFJbV5AXv+4bJWZjz7zAKobrPdbZSoB8uVhcLsMaSxGF1ruywscey2bQoWadL2Rl7P2SD
	1JFUOcD8tYVxgC2KvP5YRARzoCDcP9BA/8MNK6w==
X-Received: by 2002:a05:6808:4f27:b0:4f1:9d5b:3113 with SMTP id
 5614622812f47-55c00426a67mr4212651b6e.67.1793012571891; Mon, 26 Oct 2026
 04:02:51 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: CryoSlayer <npetr9395@gmail.com>
Date: Mon, 26 Oct 2026 16:02:42 +0500
X-Gm-Features: AclHuK9UNJdIri-r5Z3yHHt9hbpWr32au_cCyJDDBglXQcGzi-xtTm5Jc_Z3k1I
Message-ID: <CAEabPvLxKxPAgbELoqN74ACiPcugTjwnfCEa2jLvvKf_602LNg@mail.gmail.com>
Subject: [PATCH] jfs: fix missing MAXAG bounds check in diIFree() and diAllocBit()
To: jfs-discussion@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006d0df6065ebc459c"

--0000000000006d0df6065ebc459c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Two functions in fs/jfs/jfs_imap.c compute agno from on-disk data
without checking agno < MAXAG before indexing im_agctl[MAXAG] and
im_aglock[MAXAG]. The sibling function diNewExt() already has the
correct guard =E2=80=94 this patch adds the same check to diIFree() and
diAllocBit() for consistency.

Signed-off-by: Nikita Safronov <npetr9395@gmail.com>

--0000000000006d0df6065ebc459c
Content-Type: application/octet-stream; 
	name="0001-jfs-fix-missing-MAXAG-bounds-check-in-diIFree-and-diAllocBit.patch"
Content-Disposition: attachment; 
	filename="0001-jfs-fix-missing-MAXAG-bounds-check-in-diIFree-and-diAllocBit.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvp5dtkc0>
X-Attachment-Id: f_mvp5dtkc0

RnJvbTogTmlraXRhIFNhZnJvbm92IDxucGV0cjkzOTVAZ21haWwuY29tPgpEYXRlOiBNb24sIDI2
IE9jdCAyMDI2IDEyOjAwOjAwICswNTAwClN1YmplY3Q6IFtQQVRDSF0gamZzOiBmaXggbWlzc2lu
ZyBNQVhBRyBib3VuZHMgY2hlY2sgaW4gZGlJRnJlZSgpIGFuZAogZGlBbGxvY0JpdCgpCgpUd28g
ZnVuY3Rpb25zIGNvbXB1dGUgYW4gYWxsb2NhdGlvbiBncm91cCBpbmRleCAoYWdubykgZnJvbSBv
bi1kaXNrCmRhdGEgd2l0aG91dCB2YWxpZGF0aW5nIHRoYXQgYWdubyA8IE1BWEFHIGJlZm9yZSB1
c2luZyBpdCB0byBpbmRleAp0aGUgZml4ZWQtc2l6ZSBhcnJheXMgaW1fYWdjdGxbTUFYQUddIGFu
ZCBpbV9hZ2xvY2tbTUFYQUddOgoKICBkaUlGcmVlKCkgICAgKGpmc19pbWFwLmM6ODg1KToKICAg
IGFnbm8gPSBCTEtUT0FHKEpGU19JUChpcCktPmFnc3RhcnQsIEpGU19TQkkoaXAtPmlfc2IpKTsK
ICAgIEFHX0xPQ0soaW1hcCwgYWdubyk7ICAgICAgICAgICAgIC8qIGltX2FnbG9ja1thZ25vXSAt
LSBPT0IgKi8KICAgIGltYXAtPmltX2FnY3RsW2Fnbm9dLm51bWZyZWUrKzsgLyogT09CIHdyaXRl
ICAgICAgICAgICAgICAqLwoKICBkaUFsbG9jQml0KCkgKGpmc19pbWFwLmM6MjA0Nik6CiAgICBh
Z25vID0gQkxLVE9BRyhsZTY0X3RvX2NwdShpYWdwLT5hZ3N0YXJ0KSwgLi4uKTsKICAgIGltYXAt
PmltX2FnY3RsW2Fnbm9dLmlub2ZyZWUgPSAuLi47IC8qIE9PQiB3cml0ZSAqLwoKQm90aCBhZ3N0
YXJ0IGFuZCBkYl9hZ2wyc2l6ZSAodXNlZCBieSBCTEtUT0FHKSBhcmUgcmVhZCB2ZXJiYXRpbSBm
cm9tCnRoZSBvbi1kaXNrIGltYWdlIHZpYSBsZTY0X3RvX2NwdSAvIGxlMzJfdG9fY3B1IHdpdGgg
bm8gcmFuZ2UgY2hlY2ssCmdpdmluZyBhIGxvY2FsIHVzZXIgZnVsbCBjb250cm9sIG92ZXIgYWdu
byBieSBtb3VudGluZyBhIGNyYWZ0ZWQgSkZTCmltYWdlLgoKVGhlIHNpYmxpbmcgZnVuY3Rpb24g
ZGlOZXdFeHQoKSAoamZzX2ltYXAuYzoyMTg0KSBhbHJlYWR5IHBlcmZvcm1zCnRoZSBjb3JyZWN0
IHZhbGlkYXRpb246CgogIGFnbm8gPSBCTEtUT0FHKGxlNjRfdG9fY3B1KGlhZ3AtPmFnc3RhcnQp
LCBzYmkpOwogIGlmIChhZ25vID49IE1BWEFHIHx8IGFnbm8gPCAwKQogICAgICByZXR1cm4gLUVJ
TzsKCkFkZCB0aGUgc2FtZSBndWFyZCB0byBkaUlGcmVlKCkgYW5kIGRpQWxsb2NCaXQoKSBzbyBh
bGwgdGhyZWUKZnVuY3Rpb25zIGFyZSBjb25zaXN0ZW50LgoKU2lnbmVkLW9mZi1ieTogTmlraXRh
IFNhZnJvbm92IDxucGV0cjkzOTVAZ21haWwuY29tPgotLS0KIGZzL2pmcy9qZnNfaW1hcC5jIHwg
OCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2ZzL2pmcy9qZnNfaW1hcC5jIGIvZnMvamZzL2pmc19pbWFwLmMKaW5kZXggeHh4eHh4eC4ueHh4
eHh4eCAxMDA2NDQKLS0tIGEvZnMvamZzL2pmc19pbWFwLmMKKysrIGIvZnMvamZzL2pmc19pbWFw
LmMKQEAgLTg4Myw2ICs4ODMsMTAgQEAgaW50IGRpSUZyZWUoc3RydWN0IGlub2RlICppcCkKIAkv
KiBnZXQgdGhlIGFsbG9jYXRpb24gZ3JvdXAgZm9yIHRoaXMgaW5vLgogCSAqLwogCWFnbm8gPSBC
TEtUT0FHKEpGU19JUChpcCktPmFnc3RhcnQsIEpGU19TQkkoaXAtPmlfc2IpKTsKKwlpZiAoYWdu
byA+PSBNQVhBRyB8fCBhZ25vIDwgMCkgeworCQlqZnNfZXJyb3IoaXAtPmlfc2IsICJhZ25vID0g
JWQgb3V0IG9mIGJvdW5kc1xuIiwgYWdubyk7CisJCXJldHVybiAtRUlPOworCX0KIAogCS8qIExv
Y2sgdGhlIEFHIHNwZWNpZmljIGlub2RlIG1hcCBpbmZvcm1hdGlvbgogCSAqLwpAQCAtMjA0NCw2
ICsyMDQ0LDEwIEBAIHN0YXRpYyBpbnQgZGlBbGxvY0JpdChzdHJ1Y3QgaW5vbWFwICogaW1hcCwg
c3RydWN0IGlhZyAqIGlhZ3AsIGludCBpbm8pCiAJYWdubyA9IEJMS1RPQUcobGU2NF90b19jcHUo
aWFncC0+YWdzdGFydCksCiAJCSAgICAgICBKRlNfU0JJKGltYXAtPmltX2lwaW1hcC0+aV9zYikp
OworCWlmIChhZ25vID49IE1BWEFHIHx8IGFnbm8gPCAwKSB7CisJCWpmc19lcnJvcihpbWFwLT5p
bV9pcGltYXAtPmlfc2IsCisJCQkgICJhZ25vID0gJWQgb3V0IG9mIGJvdW5kc1xuIiwgYWdubyk7
CisJCXJldHVybiAtRUlPOworCX0KIAlleHRubyA9IGlubyA+PiBMMklOT1NQRVJFWFQ7Cg==
--0000000000006d0df6065ebc459c--
