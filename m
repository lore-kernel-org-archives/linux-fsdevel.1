Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD125B095
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791852751; cv=none; b=qMElXBdUkYqJwncMlqzcbo2wh+PSsruPheAjbzD0mjvq+d9LcVujM1knrL8RI+Wn7v9O8UCvsbwcuDnzFl1ZW439c0TE73rWUwKOreHVgUl9vwRDdHlQtr83DqcJnRsgUmhEZCa/faljdg8KlB3oHdqZUdVpLM7dwFGxVXWDbns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791852751; c=relaxed/simple;
	bh=dyWWqaEtTbLjjI6LcPg/RWW7c3xDwx0JIAoZ6M2Ek4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bkx+ISiMjhMtG8chDNjl+Nh1v4trnO9ojxn3Gn4YPZ27LWEbxpDnzMxUrFZ5eQHGKCC8uCHqzzRT4IdVOAziMDTqGPrtO/+v0crxBaSLakKvBlrTDc6b4KicMeSRflpWbgSSZZY/rs5wZ3YJRbnbQNAuQp3GGnmlVFs7tR+tPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9PaM8VX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9PaM8VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684D21F008A1
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 00:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791852750;
	bh=GazLl4ykvN6OWa8y0ujvFAirqTHw+cI5zszsCtx7GT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c9PaM8VXdRQz6AD07HoByEed0ogfeuYp50hG7E2KZYFDPDGBtPFNnyZaSbgCtm1Yv
	 Mk5vez19ZHkEKa0Ts2c+2TGPWdl8YK6xB90aNbqycbTjdrcPimPuy4Oeh2/aAyOPuC
	 UA7iUDNAG1l5uB2fQK3Lle0ZXqAybdk7F8txHrcTBoGKkp4j4iGZucevoTpLb+cr6Z
	 IkAdkMzd+qx7g4GLIaevt4xDygcvjOeMy8hnPS2TBJfrlZfvz0DRBh86HTAFMP4Ge3
	 F/GKN/a+NHHOLAJdodnB6hsQPewl9UVwsfKqD5mSQ+SmkgmOcIiihHVEdqZjzS5qsG
	 tRt96uwUCcwVw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c360ab7a6f9so117764966b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 17:52:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwq+TbcQeFEtxsHVfuIvCRK97uofmXT8hRKax/RUsTQB9THyx5T5/md9iFRRCOw62x0tBZmLulSSJ/dtflE@vger.kernel.org
X-Gm-Message-State: AFq9FYI2MQHsppx6mSB0IRkcvfvtsPp+kBRPjVSo+mplgmzNw2qu35un
	WcVR6g8ek6Jl2+UHZAvqrkrrr4B8gkFQSSPFhFdmSnh85ms/s7Hal/Q0lFYKo5RPQR2s1S1grYC
	EWZFO3WSC8Zw709+aYm20KH897ZOw3gE=
X-Received: by 2002:a17:907:6d14:b0:c2e:4292:d261 with SMTP id
 a640c23a62f3a-c31a9fa122dmr1037010466b.17.1791852748940; Mon, 12 Oct 2026
 17:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_8D6FD09121A77E53BCA86E1FB228DC54A107@qq.com>
In-Reply-To: <tencent_8D6FD09121A77E53BCA86E1FB228DC54A107@qq.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 13 Oct 2026 09:52:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_CP7OrKRkLwFkoLh-ADvin+oQXfj1HuDBwiEbG-LWX=Q@mail.gmail.com>
X-Gm-Features: AclHuK_N69zrMpSrUKk1mYkwI1Ck9ZfJSaad0zElYvRYRH_oPlICIyWNBULcha4
Message-ID: <CAKYAXd_CP7OrKRkLwFkoLh-ADvin+oQXfj1HuDBwiEbG-LWX=Q@mail.gmail.com>
Subject: Re: [BUG REPORT] ntfs: NULL pointer dereference in ntfs_ie_add() on
 mkdir() in a crafted image
To: 1sh1ro <yangguikun19@qq.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000975b3b065dae3a48"

--000000000000975b3b065dae3a48
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 5:58=E2=80=AFPM 1sh1ro <yangguikun19@qq.com> wrote:
>
> Hi Namjae, Hyunchul,
>
> a crafted NTFS image makes the classic NTFS driver (fs/ntfs) dereference =
a
> NULL pointer when a directory entry is added, which oopses (and panics
> outright on kernels built with panic_on_warn/panic_on_oops, as syzkaller'=
s
> are).  Found by syzbot-style fuzzing of 7.2-rc5; the code is unchanged in
> current mainline (checked against 7.3-rc5 sources).
Can you confirm if an attached patch fixes this issue?
Thanks!

--000000000000975b3b065dae3a48
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ntfs-fix-NULL-dereference-on-index-allocation-open-f.patch"
Content-Disposition: attachment; 
	filename="0001-ntfs-fix-NULL-dereference-on-index-allocation-open-f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mv5yttj70>
X-Attachment-Id: f_mv5yttj70

RnJvbSA5ZmNiNmY3NjNhMTBiN2MyOWU3NTVhMTRjOTI0M2JkZWM4NGY4Nzg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDEzIE9jdCAyMDI2IDA5OjE1OjAwICswOTAwClN1YmplY3Q6IFtQQVRDSF0gbnRm
czogZml4IE5VTEwgZGVyZWZlcmVuY2Ugb24gaW5kZXggYWxsb2NhdGlvbiBvcGVuIGZhaWx1cmUK
Cm50ZnNfaW5kZXhfbG9va3VwKCkgcmV0dXJucyAtRU5PRU5UIHdoZW4gbnRmc19pYV9vcGVuKCkg
ZmFpbHMgdG8gb3BlbiB0aGUKaW5kZXggYWxsb2NhdGlvbi4gVGhpcyBlcnJvciBwYXRoIGxlYXZl
cyBpY3gtPmliIHVuc2V0LCB1bmxpa2UgYSBtaXNzaW5nCmtleSBpbiBhbiBvdGhlcndpc2UgdmFs
aWQgaW5kZXgsIHdoaWNoIHJldHVybnMgYW4gaW5zZXJ0aW9uIGNvbnRleHQuCgpudGZzX2llX2Fk
ZCgpIHRyZWF0cyAtRU5PRU5UIGFzIGEgdmFsaWQgaW5zZXJ0aW9uIHBvc2l0aW9uIGFuZCBkZXJl
ZmVyZW5jZXMKaWN4LT5pYiB3aGVuIHRoZSBsb29rdXAgaXMgbm90IGluIHRoZSBpbmRleCByb290
LiBBIGNvcnJ1cHQgJEkzMCBiaXRtYXAKYXR0cmlidXRlIGNhbiB0aGVyZWZvcmUgY2F1c2UgYSBO
VUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2hlbiBhZGRpbmcgYQpkaXJlY3RvcnkgZW50cnkuCgpS
ZXR1cm4gLUVJTyBmb3IgaW5kZXggYWxsb2NhdGlvbiBvcGVuIGZhaWx1cmVzIHNvIGluc2VydGlv
biBhYm9ydHMgdGhyb3VnaAp0aGUgZXhpc3RpbmcgZXJyb3IgcGF0aC4gS2VlcCAtRU5PRU5UIGZv
ciBnZW51aW5lbHkgbWlzc2luZyBrZXlzIGFuZApkb2N1bWVudCB0aGF0IG90aGVyIGVycm9ycyBs
ZWF2ZSBubyB2YWxpZCBpbmRleCBlbnRyeS4KCkZpeGVzOiAwYThhYzBjMWZhMGIgKCJudGZzOiB1
cGRhdGUgZGlyZWN0b3J5IG9wZXJhdGlvbnMiKQpSZXBvcnRlZC1ieTogMXNoMXJvIDx5YW5nZ3Vp
a3VuMTlAcXEuY29tPgpTaWduZWQtb2ZmLWJ5OiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJu
ZWwub3JnPgotLS0KIGZzL250ZnMvaW5kZXguYyB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9udGZzL2luZGV4
LmMgYi9mcy9udGZzL2luZGV4LmMKaW5kZXggNDQxMGRmMGE4ZjMxLi5hYzIyZDg0MDdhNzcgMTAw
NjQ0Ci0tLSBhL2ZzL250ZnMvaW5kZXguYworKysgYi9mcy9udGZzL2luZGV4LmMKQEAgLTgxMiw2
ICs4MTIsOSBAQCBzdGF0aWMgaW50IG50ZnNfaWN4X3BhcmVudF9kZWMoc3RydWN0IG50ZnNfaW5k
ZXhfY29udGV4dCAqaWN4KQogICogYWZ0ZXIgdGhlIHNlYXJjaCBAa2V5LCBpLmUuIHRoaXMgaXMg
dGhlIHBvc2l0aW9uIGluIHRoZSBpbmRleCBhdCB3aGljaAogICogYW4gaW5kZXggZW50cnkgd2l0
aCBhIGtleSBvZiBAa2V5IHdvdWxkIG5lZWQgdG8gYmUgaW5zZXJ0ZWQuCiAgKgorICogSWYgdGhl
IGluZGV4IGNhbm5vdCBiZSBzZWFyY2hlZCwgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG90aGVyIHRo
YW4gLUVOT0VOVAorICogaXMgcmV0dXJuZWQgYW5kIEBpY3ggZG9lcyBub3QgZGVzY3JpYmUgYSB2
YWxpZCBpbmRleCBlbnRyeS4KKyAqCiAgKiBXaGVuIGZpbmlzaGVkIHdpdGggdGhlIGVudHJ5IGFu
ZCBpdHMgZGF0YSwgY2FsbCBudGZzX2luZGV4X2N0eF9wdXQoKSB0byBmcmVlCiAgKiB0aGUgY29u
dGV4dCBhbmQgb3RoZXIgYXNzb2NpYXRlZCByZXNvdXJjZXMuCiAgKgpAQCAtODc3LDcgKzg4MCw3
IEBAIGludCBudGZzX2luZGV4X2xvb2t1cChjb25zdCB2b2lkICprZXksIGNvbnN0IHUzMiBrZXlf
bGVuLCBzdHJ1Y3QgbnRmc19pbmRleF9jb250CiAJLyogQ2hpbGQgbm9kZSBwcmVzZW50LCBkZXNj
ZW5kIGludG8gaXQuICovCiAJaWN4LT5pYV9uaSA9IG50ZnNfaWFfb3BlbihpY3gsIG5pKTsKIAlp
ZiAoIWljeC0+aWFfbmkpIHsKLQkJZXJyID0gLUVOT0VOVDsKKwkJZXJyID0gLUVJTzsKIAkJZ290
byBlcnJfb3V0OwogCX0KIAotLSAKMi4zNC4xCgo=
--000000000000975b3b065dae3a48--
