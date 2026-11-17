Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944911;
	b=U0mNVFU5mrwxUR++QVFmtFQFy0TJ08p25ApofshZXA9R7Ulkv6YQp7sEiUo6jq5OIkDb
	 MGZR5zUzkPtjMCDxOXRwJEnwK42/OAQR2H9v82RzjKYVnwf587RhAy6xO0vMAJxtuYLED
	 Zf/u/S8o9FzQ8Bg7Tv24vr7438EjxVnBwhXroWpSj02LxzsrXXZRmt6fFuvopPpYQyO59
	 fAjfclYQ4CbxVAj4Ct4Aa+WbL+j3IiWBZkOKWW+ugw/zJe8AlV/SU1RORPXi1+2E34Sdl
	 cuiKid29UPdO3p67eGBcfZ304NTP6s0BZHDKYGYLOto9PSQg3VLdbsec5ie3p3i3EcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pz8l3qiBqUBWhr0HS/plvY5iqW0Uso2hEdf4B7cUURE=;
	b=Ziq0u77DYAbVpPq8t/eVRH+Jzm0vbyXNqXzf94i5MUUB8nv4L6Zo4lQW+VOcbnRXPEyK
	 GQ2EB7utRfbZvjuQtnp2jP+iKdPc8jiPnHS2pGeYabNDvNSVexMzOOJwX1oLW1Z7MoBJm
	 LrShFQR4ZX2N1YucwJ3l2wLQDsSdSyL8DhmUhpC4jcnjnWgFFSO8ZlwmhVF6URZ7doiMf
	 KDEtqrmJ4DQuVFbTJnEv9rglho4Nay8/McypVWja7KkhMV66RxNWbBN17G5wPFz0qY0PA
	 BGetJWCqIc6EBsInR3ibFIARwVWp+lHtYyq1hL3D7yimRH4Cw4kB4/rixUzqmzHMwyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b="Lx9N/G/c";
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA43606A32F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 19:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA43606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Lx9N/G/c
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d28f75d62so19004666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794944909; x=1795549709; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pz8l3qiBqUBWhr0HS/plvY5iqW0Uso2hEdf4B7cUURE=;
        b=Lx9N/G/cjpCsv3nfo52ONLRLV6o0nidLkD4rsv38LzSQfN/KWog0h0lTPTmvxqYtCN
         2Ju1+mKQJC5HafTG/M1XvRFEMD5Z5e9O7MOkEDH2L5HxhmCQIHFKqW+Wo1qu8sFSgZay
         m6zxLO3st2Rx88L4FNSyC/1qAvbaRtnvlg9kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794944909; x=1795549709;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pz8l3qiBqUBWhr0HS/plvY5iqW0Uso2hEdf4B7cUURE=;
        b=eCR8Xur/Dl+YmSzgI5CJvdoKpzzN3w8OXqaT+0gReaTQWQLeJvh4l0X/eIXMBtdqQF
         QCkqaGWFR78V4JlzLlBGHhw/qXFRqQ3qcdu05XWrLBeB+RJvT9huwfuexY5NdcyXFcxO
         OaHEEc4SBBGgRqFMDqr4XHUVT1sP+abKTAW0xrQYfZ8+WyA/EGxCVvPT/+F+0hWc2I3r
         ghNXrsACdDk9Ol073YJtsbgZQdi8c2haKYbpMol8jIVjgZiUNFQc3aAwrt4oMK0kcJ0g
         hI3ChJ3wVp11xAO1be1E6KGwMTeU1PR/23kq2lMBqUFXw3+3VyHE+oXseaSvzIfn3gc8
         L9rA==
X-Forwarded-Encrypted: i=1; AL+hErH+WQpcF0F96PXgHKYvjav3SgthWz5sE43UWKs6OijLKpFwotLavzCnCNlwd4K7m3wqFdAp41WaXs9ol8hq@vger.kernel.org
X-Gm-Message-State: APuU4Z87Gxg3yz/dr+ql/on3PGc4P0dTfZ65HR/Ghr0rLJ/C2yiMVl/p
	JQ8YK2WqPjkTzAQCoXpJud4iy/jao2Ec1JEHWze2IJ92AIlMyEA6Tp86OIUjmLrsnZezfqIk2D3
	jiP7UhQvRng==
X-Gm-Gg: AYBFou1ecGBXNJ4qR7IBKg3Wpwin+tp3WrNHaT8WruP6jBcPHW9UfKaaKtiAWh/Sp0M
	XFb2Sv+AeemNujx1DQ0pKnrWouiUCRJX+ZCGR0yKIDc9FANnXPX+iVV2IkRMBBSXIxpHkhWMiwL
	zKvCECO63va3GJoJgVwb4PHCny1wflCFPvuh6enDW9nqA2IUdH8n1oQNs3M8Yz5Nr5pei75j6OE
	BydlnTzyLMrRnw82L/Cx88o4s9zyitnXitYYuTE5oJuWNLj9hvUdTdyZyzOyF2Gj5FjvJXHb9kl
	5kxRHlXHxMlNwc6LsQmM8jTJo6LSPxyJ/9LmhK1TZx6nxtHRu2bDWxWor6cF7ZLMMsbru2YLu+A
	TeTkpIZPub1ONw2OJ0twjrR9mxUM4ZT1mdVogiqq0fp+7UfJR3rVZSwqUeyhX+5Dk1umTnaI1ui
	DNxFteoRXqNVneWk9XvD3EzPvQodUaW4wVq7t82nVIHIp1pMo/NtwdBc1u/I0XPpwzhKLSK9qRp
	KGxIfIYrLqgQf8xTtuhUYWoZnzioaxYnYPGM7yB+2kV2wGdtxrEqEwW2K2oWc/+edzHkgHIlt2r
	dmGiwgdc0rYXgY0W2ojm10wOVcb7rp9q9WGe+f0N2aHg9v/CBlTLJLUSPGLS5TXRRewvkaWeCq8
	kqB4=
X-Received: by 2002:a17:907:3d10:b0:c41:9228:baef with SMTP id a640c23a62f3a-c510e22adb7mr26877766b.8.1794944909354;
        Tue, 17 Nov 2026 11:48:29 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cb32535sm15868866b.69.2026.11.17.11.48.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 11:48:26 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d28f75d62so18995066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:48:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHdkNpssgFFfvgFLMLhSFURz5eIhRf1utXwr6tmvgH4osTFVbdz0ndmPeQcs8CWYuFfgcJrHlZ0GJofxfTi@vger.kernel.org
X-Received: by 2002:a17:906:c141:b0:c3f:55e6:83e6 with SMTP id
 a640c23a62f3a-c510e22a312mr23480066b.15.1794944905938; Tue, 17 Nov 2026
 11:48:25 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com> <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com> <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com> <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
In-Reply-To: <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Nov 2026 11:48:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
X-Gm-Features: AclHuK_utMadaL_dZX_sEFGqmttVnRSlgsZcdf_Rq4dgHcJ507Z8LlKBWadx-x0
Message-ID: <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: multipart/mixed; boundary="00000000000082d9da06607e2d62"

--00000000000082d9da06607e2d62
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Nov 2026 at 11:12, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, I looked at this, and it gets ugly

Side note: as part of looking at it, I did look at what it would
involve in our wait.h infrastructure.

That header isn't _horrible_, but some of it was uglier than needed,
and adding WQ_FLAG_PRIORITY would have been a huge pain because the
code unnecessarily special-cases WQ_FLAG_EXCLUSIVE.

So while I threw the rest of my trial patch away, this patch remained
as a cleanup. It *looks* sane to me, and I think the end result looks
better and would be more flexible.

For example, it would have allowed just adding a new user of
___wait_event() that used WQ_FLAG_PRIORITY to put itself at the head
of the queue.

NOTE! Entirely untested. Comments?

              Linus

--00000000000082d9da06607e2d62
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-wait-event-clean-up-the-internal-helper-arguments.patch"
Content-Disposition: attachment; 
	filename="0001-wait-event-clean-up-the-internal-helper-arguments.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwl3u5430>
X-Attachment-Id: f_mwl3u5430

RnJvbSBjOGY2MGQ2NzBmYTEyMTVjZTVjZDM4ZjljN2U3Y2IyNzU4YmM1YTU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTcgTm92IDIwMjYgMTE6NDI6MDMgLTA4MDAKU3ViamVjdDog
W1BBVENIXSB3YWl0LWV2ZW50OiBjbGVhbiB1cCB0aGUgaW50ZXJuYWwgaGVscGVyIGFyZ3VtZW50
cwoKVGhlIF9fX3dhaXRfZXZlbnQoKSBoZWxwZXIgZm9yIGhpc3RvcmljYWwgcmVhc29ucyB0b29r
IGEgIjAvMSIgYXJndW1lbnQKZm9yIHdoZXRoZXIgdGhlIHdhaXQtcXVldWUgZW50cnkgc2hvdWxk
IGJlIG1hcmtlZCBXUV9GTEFHX0VYQ0xVU0lWRSBvcgpub3QuICBUaGF0IGRpZG4ndCByZWFsbHkg
aGVscCByZWFkYWJpbGl0eSwgYnV0IGl0IGFsc28gbGltaXRlZCB0aGUKd3FfZmxhZ3MgZm9yIHRo
YXQgaGVscGVyIHRvIG9ubHkgdGhhdCBvbmUgZmxhZy4KCkp1c3QgbWFrZSB0aGF0IG1hY3JvIGFy
Z3VtZW50IGJlIHRoZSBhY3R1YWwgJ3dxX2ZsYWdzJyB2YWx1ZSwgd2hpY2gKc2ltcGxpZmllcyB0
aGUgaGVscGVyLCBhbmQgbWFrZXMgaXQgbW9yZSBnZW5lcmljLiAgSXQgYWxzbyBoYXBwZW5zIHRv
Cm1ha2UgdGhlIHVzZXJzIG9mIHRoaXMgbWFjcm8gbW9yZSBvYnZpb3VzIHdoZW4gYW4gdW5leHBs
YWluZWQgJzEnCmFyZ3VtZW50IGJlY29tZXMgYSBtb3JlIHNlbGYtZXhwbGFuYXRvcnkgJ1dRX0ZM
QUdfRVhDTFVTSVZFJy4KCkFsc28gY2hhbmdlIHRoZSBleGlzdGluZyB1c2VycyB0aGF0IHVzZSB0
aGF0IHJhdyBfX193YWl0X2V2ZW50KCkKaW50ZXJmYWNlIHdpdGgganVzdCBhIHBsYWluIHNjaGVk
dWxlKCkgdG8gdXNlIHRoZSBwcmUtZXhpc3RpbmcgaGVscGVycwptYWNyb3M6IF9fd2FpdF9ldmVu
dF9zdGF0ZSgpIGFuZCBfX3dhaXRfZXZlbnRfc3RhdGVfZXhjbHVzaXZlKCkuCgpTaWduZWQtb2Zm
LWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0tLQog
aW5jbHVkZS9saW51eC93YWl0LmggfCAzNiArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3dhaXQuaCBiL2luY2x1ZGUvbGludXgvd2FpdC5o
CmluZGV4IGMyYWY5OGIwMDc0ZC4uYjNlOTRjNzFjZDNlIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L3dhaXQuaAorKysgYi9pbmNsdWRlL2xpbnV4L3dhaXQuaApAQCAtMjk5LDEzICsyOTksMTMg
QEAgZXh0ZXJuIHZvaWQgaW5pdF93YWl0X2VudHJ5KHN0cnVjdCB3YWl0X3F1ZXVlX2VudHJ5ICp3
cV9lbnRyeSwgaW50IGZsYWdzKTsKICAqIG90aGVyd2lzZS4KICAqLwogCi0jZGVmaW5lIF9fX3dh
aXRfZXZlbnQod3FfaGVhZCwgY29uZGl0aW9uLCBzdGF0ZSwgZXhjbHVzaXZlLCByZXQsIGNtZCkJ
CVwKKyNkZWZpbmUgX19fd2FpdF9ldmVudCh3cV9oZWFkLCBjb25kaXRpb24sIHN0YXRlLCB3cV9m
bGFnLCByZXQsIGNtZCkJCVwKICh7CQkJCQkJCQkJCVwKIAlfX2xhYmVsX18gX19vdXQ7CQkJCQkJ
CVwKIAlzdHJ1Y3Qgd2FpdF9xdWV1ZV9lbnRyeSBfX3dxX2VudHJ5OwkJCQkJXAogCWxvbmcgX19y
ZXQgPSByZXQ7CS8qIGV4cGxpY2l0IHNoYWRvdyAqLwkJCQlcCiAJCQkJCQkJCQkJXAotCWluaXRf
d2FpdF9lbnRyeSgmX193cV9lbnRyeSwgZXhjbHVzaXZlID8gV1FfRkxBR19FWENMVVNJVkUgOiAw
KTsJXAorCWluaXRfd2FpdF9lbnRyeSgmX193cV9lbnRyeSwgd3FfZmxhZyk7CQkJCQlcCiAJZm9y
ICg7OykgewkJCQkJCQkJXAogCQlsb25nIF9faW50ID0gcHJlcGFyZV90b193YWl0X2V2ZW50KCZ3
cV9oZWFkLCAmX193cV9lbnRyeSwgc3RhdGUpO1wKIAkJCQkJCQkJCQlcCkBAIC0zMjcsOCArMzI3
LDcgQEAgX19vdXQ6CV9fcmV0OwkJCQkJCQkJCVwKIH0pCiAKICNkZWZpbmUgX193YWl0X2V2ZW50
KHdxX2hlYWQsIGNvbmRpdGlvbikJCQkJCVwKLQkodm9pZClfX193YWl0X2V2ZW50KHdxX2hlYWQs
IGNvbmRpdGlvbiwgVEFTS19VTklOVEVSUlVQVElCTEUsIDAsIDAsCVwKLQkJCSAgICBzY2hlZHVs
ZSgpKQorCSh2b2lkKV9fd2FpdF9ldmVudF9zdGF0ZSh3cV9oZWFkLCBjb25kaXRpb24sIFRBU0tf
VU5JTlRFUlJVUFRJQkxFKQogCiAvKioKICAqIHdhaXRfZXZlbnQgLSBzbGVlcCB1bnRpbCBhIGNv
bmRpdGlvbiBnZXRzIHRydWUKQEAgLTM2Niw4ICszNjUsNyBAQCBkbyB7CQkJCQkJCQkJCVwKIH0g
d2hpbGUgKDApCiAKICNkZWZpbmUgX193YWl0X2V2ZW50X2ZyZWV6YWJsZSh3cV9oZWFkLCBjb25k
aXRpb24pCQkJCVwKLQlfX193YWl0X2V2ZW50KHdxX2hlYWQsIGNvbmRpdGlvbiwgKFRBU0tfSU5U
RVJSVVBUSUJMRXxUQVNLX0ZSRUVaQUJMRSksCVwKLQkJCTAsIDAsIHNjaGVkdWxlKCkpCisJX193
YWl0X2V2ZW50X3N0YXRlKHdxX2hlYWQsIGNvbmRpdGlvbiwgKFRBU0tfSU5URVJSVVBUSUJMRXxU
QVNLX0ZSRUVaQUJMRSkpCiAKIC8qKgogICogd2FpdF9ldmVudF9mcmVlemFibGUgLSBzbGVlcCAo
b3IgZnJlZXplKSB1bnRpbCBhIGNvbmRpdGlvbiBnZXRzIHRydWUKQEAgLTQ0Miw4ICs0NDAsOCBA
QCBkbyB7CQkJCQkJCQkJCVwKIH0pCiAKICNkZWZpbmUgX193YWl0X2V2ZW50X2V4Y2x1c2l2ZV9j
bWQod3FfaGVhZCwgY29uZGl0aW9uLCBjbWQxLCBjbWQyKQkJXAotCSh2b2lkKV9fX3dhaXRfZXZl
bnQod3FfaGVhZCwgY29uZGl0aW9uLCBUQVNLX1VOSU5URVJSVVBUSUJMRSwgMSwgMCwJXAotCQkJ
ICAgIGNtZDE7IHNjaGVkdWxlKCk7IGNtZDIpCisJKHZvaWQpX19fd2FpdF9ldmVudCh3cV9oZWFk
LCBjb25kaXRpb24sIFRBU0tfVU5JTlRFUlJVUFRJQkxFLAkJXAorCQkJICAgIFdRX0ZMQUdfRVhD
TFVTSVZFLCAwLCBjbWQxOyBzY2hlZHVsZSgpOyBjbWQyKQogLyoKICAqIEp1c3QgbGlrZSB3YWl0
X2V2ZW50X2NtZCgpLCBleGNlcHQgaXQgc2V0cyBleGNsdXNpdmUgZmxhZwogICovCkBAIC00ODAs
OCArNDc4LDcgQEAgZG8gewkJCQkJCQkJCQlcCiB9IHdoaWxlICgwKQogCiAjZGVmaW5lIF9fd2Fp
dF9ldmVudF9pbnRlcnJ1cHRpYmxlKHdxX2hlYWQsIGNvbmRpdGlvbikJCQkJXAotCV9fX3dhaXRf
ZXZlbnQod3FfaGVhZCwgY29uZGl0aW9uLCBUQVNLX0lOVEVSUlVQVElCTEUsIDAsIDAsCQlcCi0J
CSAgICAgIHNjaGVkdWxlKCkpCisJX193YWl0X2V2ZW50X3N0YXRlKHdxX2hlYWQsIGNvbmRpdGlv
biwgVEFTS19JTlRFUlJVUFRJQkxFKQogCiAvKioKICAqIHdhaXRfZXZlbnRfaW50ZXJydXB0aWJs
ZSAtIHNsZWVwIHVudGlsIGEgY29uZGl0aW9uIGdldHMgdHJ1ZQpAQCAtNjIwLDggKzYxNyw3IEBA
IGRvIHsJCQkJCQkJCQkJXAogfSkKIAogI2RlZmluZSBfX3dhaXRfZXZlbnRfaW50ZXJydXB0aWJs
ZV9leGNsdXNpdmUod3EsIGNvbmRpdGlvbikJCQlcCi0JX19fd2FpdF9ldmVudCh3cSwgY29uZGl0
aW9uLCBUQVNLX0lOVEVSUlVQVElCTEUsIDEsIDAsCQkJXAotCQkgICAgICBzY2hlZHVsZSgpKQor
CV9fd2FpdF9ldmVudF9zdGF0ZV9leGNsdXNpdmUod3EsIGNvbmRpdGlvbiwgVEFTS19JTlRFUlJV
UFRJQkxFKQogCiAjZGVmaW5lIHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV9leGNsdXNpdmUod3Es
IGNvbmRpdGlvbikJCQlcCiAoewkJCQkJCQkJCQlcCkBAIC02MzMsOCArNjI5LDcgQEAgZG8gewkJ
CQkJCQkJCQlcCiB9KQogCiAjZGVmaW5lIF9fd2FpdF9ldmVudF9raWxsYWJsZV9leGNsdXNpdmUo
d3EsIGNvbmRpdGlvbikJCQkJXAotCV9fX3dhaXRfZXZlbnQod3EsIGNvbmRpdGlvbiwgVEFTS19L
SUxMQUJMRSwgMSwgMCwJCQlcCi0JCSAgICAgIHNjaGVkdWxlKCkpCisJX193YWl0X2V2ZW50X3N0
YXRlX2V4Y2x1c2l2ZSh3cSwgY29uZGl0aW9uLCBUQVNLX0tJTExBQkxFKQogCiAjZGVmaW5lIHdh
aXRfZXZlbnRfa2lsbGFibGVfZXhjbHVzaXZlKHdxLCBjb25kaXRpb24pCQkJCVwKICh7CQkJCQkJ
CQkJCVwKQEAgLTY0Nyw4ICs2NDIsNyBAQCBkbyB7CQkJCQkJCQkJCVwKIAogCiAjZGVmaW5lIF9f
d2FpdF9ldmVudF9mcmVlemFibGVfZXhjbHVzaXZlKHdxLCBjb25kaXRpb24pCQkJCVwKLQlfX193
YWl0X2V2ZW50KHdxLCBjb25kaXRpb24sIChUQVNLX0lOVEVSUlVQVElCTEV8VEFTS19GUkVFWkFC
TEUpLCAxLCAwLFwKLQkJCXNjaGVkdWxlKCkpCisJX193YWl0X2V2ZW50X3N0YXRlX2V4Y2x1c2l2
ZSh3cSwgY29uZGl0aW9uLCAoVEFTS19JTlRFUlJVUFRJQkxFfFRBU0tfRlJFRVpBQkxFKSkKIAog
I2RlZmluZSB3YWl0X2V2ZW50X2ZyZWV6YWJsZV9leGNsdXNpdmUod3EsIGNvbmRpdGlvbikJCQkJ
XAogKHsJCQkJCQkJCQkJXApAQCAtNjc2LDcgKzY3MCw3IEBAIGRvIHsJCQkJCQkJCQkJXAogZG8g
ewkJCQkJCQkJCQlcCiAJbWlnaHRfc2xlZXAoKTsJCQkJCQkJCVwKIAlpZiAoIShjb25kaXRpb24p
KQkJCQkJCQlcCi0JCV9fX3dhaXRfZXZlbnQod3FfaGVhZCwgY29uZGl0aW9uLCBUQVNLX0lETEUs
IDAsIDAsIHNjaGVkdWxlKCkpOwlcCisJCV9fd2FpdF9ldmVudF9zdGF0ZSh3cV9oZWFkLCBjb25k
aXRpb24sIFRBU0tfSURMRSk7CQlcCiB9IHdoaWxlICgwKQogCiAvKioKQEAgLTcwMCw3ICs2OTQs
NyBAQCBkbyB7CQkJCQkJCQkJCVwKIGRvIHsJCQkJCQkJCQkJXAogCW1pZ2h0X3NsZWVwKCk7CQkJ
CQkJCQlcCiAJaWYgKCEoY29uZGl0aW9uKSkJCQkJCQkJXAotCQlfX193YWl0X2V2ZW50KHdxX2hl
YWQsIGNvbmRpdGlvbiwgVEFTS19JRExFLCAxLCAwLCBzY2hlZHVsZSgpKTsJXAorCQlfX3dhaXRf
ZXZlbnRfc3RhdGVfZXhjbHVzaXZlKHdxX2hlYWQsIGNvbmRpdGlvbiwgVEFTS19JRExFKTsJXAog
fSB3aGlsZSAoMCkKIAogI2RlZmluZSBfX3dhaXRfZXZlbnRfaWRsZV90aW1lb3V0KHdxX2hlYWQs
IGNvbmRpdGlvbiwgdGltZW91dCkJCQlcCkBAIC03MzgsNyArNzMyLDcgQEAgZG8gewkJCQkJCQkJ
CQlcCiAKICNkZWZpbmUgX193YWl0X2V2ZW50X2lkbGVfZXhjbHVzaXZlX3RpbWVvdXQod3FfaGVh
ZCwgY29uZGl0aW9uLCB0aW1lb3V0KQlcCiAJX19fd2FpdF9ldmVudCh3cV9oZWFkLCBfX193YWl0
X2NvbmRfdGltZW91dChjb25kaXRpb24pLAkJCVwKLQkJICAgICAgVEFTS19JRExFLCAxLCB0aW1l
b3V0LAkJCQkJXAorCQkgICAgICBUQVNLX0lETEUsIFdRX0ZMQUdfRVhDTFVTSVZFLCB0aW1lb3V0
LAkJCVwKIAkJICAgICAgX19yZXQgPSBzY2hlZHVsZV90aW1lb3V0KF9fcmV0KSkKIAogLyoqCkBA
IC05MTEsNyArOTA1LDcgQEAgZXh0ZXJuIGludCBkb193YWl0X2ludHJfaXJxKHdhaXRfcXVldWVf
aGVhZF90ICosIHdhaXRfcXVldWVfZW50cnlfdCAqKTsKIAogCiAjZGVmaW5lIF9fd2FpdF9ldmVu
dF9raWxsYWJsZSh3cSwgY29uZGl0aW9uKQkJCQkJXAotCV9fX3dhaXRfZXZlbnQod3EsIGNvbmRp
dGlvbiwgVEFTS19LSUxMQUJMRSwgMCwgMCwgc2NoZWR1bGUoKSkKKwlfX3dhaXRfZXZlbnRfc3Rh
dGUod3EsIGNvbmRpdGlvbiwgVEFTS19LSUxMQUJMRSkKIAogLyoqCiAgKiB3YWl0X2V2ZW50X2tp
bGxhYmxlIC0gc2xlZXAgdW50aWwgYSBjb25kaXRpb24gZ2V0cyB0cnVlCkBAIC05ODEsNyArOTc1
LDcgQEAgZXh0ZXJuIGludCBkb193YWl0X2ludHJfaXJxKHdhaXRfcXVldWVfaGVhZF90ICosIHdh
aXRfcXVldWVfZW50cnlfdCAqKTsKIH0pCiAKICNkZWZpbmUgX193YWl0X2V2ZW50X3N0YXRlX2V4
Y2x1c2l2ZSh3cSwgY29uZGl0aW9uLCBzdGF0ZSkJCQlcCi0JX19fd2FpdF9ldmVudCh3cSwgY29u
ZGl0aW9uLCBzdGF0ZSwgMSwgMCwgc2NoZWR1bGUoKSkKKwlfX193YWl0X2V2ZW50KHdxLCBjb25k
aXRpb24sIHN0YXRlLCBXUV9GTEFHX0VYQ0xVU0lWRSwgMCwgc2NoZWR1bGUoKSkKIAogI2RlZmlu
ZSB3YWl0X2V2ZW50X3N0YXRlX2V4Y2x1c2l2ZSh3cSwgY29uZGl0aW9uLCBzdGF0ZSkJCQlcCiAo
ewkJCQkJCQkJCQlcCi0tIAoyLjU2LjAuMzEzLmc5NzVhNzVjYTkwCgo=
--00000000000082d9da06607e2d62--
