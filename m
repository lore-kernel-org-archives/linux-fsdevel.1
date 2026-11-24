Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484435;
	b=2t9aOSt12PZJoNY/Cuh5HwxwdgScpDlkGrEM8VSGUUrp5GsCPlPVf2XF65wBzO3CzWpa
	 qITUtmZKKA9DUinSYmM3hYyKX65oNuvrR5O2VM9okKHQ7sMnR1ehOD0IYbGzzqJxHDWkw
	 m/KjQXd6Om1JIxdYKDLVkSMubt5JQFffbRrTVajH6bbhR9ppqkhmsp23D4W8XSXf3Mqxr
	 PU8EaBrV4CpnLhh3WEWpseZkyBiMJ3Oxe7haeJLiE2dPcjbvu8N9+oFcZJ6LkYwCiM7CP
	 NFaLSeQ1jxXJ98328IFX8nTANbWWePgbqS5NsPj07jMcteZpWwkPA/GttVzinCCmBBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484435;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=aQyla5gznIxGOTl6iNdkOfmmKCQQwlqTP2RnxhnWTxE=;
	b=WH7ix8Moyq5Wzs4QGBCpNy10nrRXqk0ScSDTF0ZfhpeSv9YhPmI88POvgSm2cfoi4A5I
	 1knajSYHIhzNX4Q7Qvsq11i/l+IPkGMZv3DVo6Dt9v9zLdfYb9uVMfpwYWF8zeR0N9hLD
	 v95pEqnsMQYZgNNSBFvK+mb0WFOp2pvlcyVjRb6E+ZgqADJeA8wecduJQFhx4lF93eCPR
	 YDavEL20ondWI2HCSaixbDeSuwVs4byGsJM+v3wCnnLr+CKqRCgzZvmAYwg+lqBen5tQ1
	 9ZkhNUjNwAntv/gK3lg18f7ZdTO1MkPOxynXXMT0ywyhVJuHG4IBt3gRS+HVa5Mcy4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QGDSSw/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE90606A326
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGDSSw/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894FC1F000D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795484434;
	bh=aQyla5gznIxGOTl6iNdkOfmmKCQQwlqTP2RnxhnWTxE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QGDSSw/IGUaz3ck2TU48ENmPb221q7rHFf95tvPVYpz32ngTGT18Uf2f4YL8jSIi0
	 m1fXnoQqAXPULRLuC8e+qZqbRiuJEMa10kDYG3M2SkSKrCVAoYohokbdUZcfRygWkH
	 wFmLoIzUG4Uy8bwGGq8uALSktotZpP9swaP55bLxEOuLfuNEBJVJoYWr39MbgU0ywR
	 C1y/cAt58BxNLJw6F8A2u/6nqjrK3dcWYioZxBqs4YJrRyINvBrGn+s4C99iWKbbvA
	 TweJQLzZPqB0dsikFLy3n1yMnslYG7F0NjuvQKjDji6TWZQOJjSR3vt5wW7Kn1BOiN
	 U+lAG6+fCYA4Q==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b87408c797so5264998a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:40:34 -0800 (PST)
X-Gm-Message-State: APuU4Z9qCJFATnxtVF5NUTjoRnfZzfKLn4CKrNWBHQxnQXYIh0YtBwt6
	I1s4Sro/SwvV6G9v/2FLxG5eVbjQAj8Sb78Nhk/lwarmlhzIUZUYvJqKfGkYywRQVdF0QN8vS8/
	maVEItX6wyc3baxq5sETE3/2wrioe/pA=
X-Received: by 2002:a17:907:3d56:b0:c4c:e344:ecec with SMTP id
 a640c23a62f3a-c513a3a6578mr1079128366b.6.1795484433117; Mon, 23 Nov 2026
 17:40:33 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <DM4PR15MB6276A5C442568B4C7E604AA386452@DM4PR15MB6276.namprd15.prod.outlook.com>
In-Reply-To: <DM4PR15MB6276A5C442568B4C7E604AA386452@DM4PR15MB6276.namprd15.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 24 Nov 2026 10:40:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-MHxzjvc20J-x4VYBnuk3sVpzmHo+zrHb8n3nx8Aav6g@mail.gmail.com>
X-Gm-Features: Aa3M54r5fFmuAQFBHjN1hf8ocpDTAW4WfVfcUZbuvJ6LZUWELv29rjXrB4konQE
Message-ID: <CAKYAXd-MHxzjvc20J-x4VYBnuk3sVpzmHo+zrHb8n3nx8Aav6g@mail.gmail.com>
Subject: Re: ntfs: deleting $Extend breaks subsequent mount
To: theBIT5 x3zk <x3zk@outlook.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"open list:NTFS FILESYSTEM" <ntfs@lists.linux.dev>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Baolin Liu <liubaolin12138@163.com>, Baolin Liu <liubaolin@kylinos.cn>
Content-Type: multipart/mixed; boundary="000000000000d638f30660fbcb7d"

--000000000000d638f30660fbcb7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:01=E2=80=AFAM theBIT5 x3zk <x3zk@outlook.com> wro=
te:
>
> Hi,
Hi,
>
> Was messing around with the new ntfs driver (fs/ntfs) on 7.4.0-rc3-1-main=
line
> and noticed you can just rm -rf '$Extend' even without show_sys_files.
> After umount, the filesystem fails to mount again.
>
> Steps:
>
> # mount -t ntfs /root/ntfs.img /mnt -o loop
> # cd /mnt
> # ls '$Extend'
> '$ObjId'  '$Quota'  '$Reparse'
> # rm -rf '$Extend'
> # cd /
> # umount /mnt
> # mount -t ntfs /root/ntfs.img /mnt -o loop
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/loop0,
>        missing codepage or helper program, or other error.
>
> dmesg:
> ntfs: volume version 3.1, dev loop0, cluster size 4096
> ntfs: (device loop0): load_system_files(): Failed to load $Extend.
> ntfs: (device loop0): ntfs_fill_super(): Failed to load system files (-22=
).
Please check the attached patch.
Thanks for the report.

--000000000000d638f30660fbcb7d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ntfs-prevent-modification-of-Extend-system-metadata.patch"
Content-Disposition: attachment; 
	filename="0001-ntfs-prevent-modification-of-Extend-system-metadata.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mwu10soc0>
X-Attachment-Id: f_mwu10soc0

RnJvbSAwMGQ1ZmNlYjNiODA3NmQ5MzdhNjQ3NjRlZTY2M2I0MDQ0NWI0MDJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDI0IE5vdiAyMDI2IDEwOjIzOjQyICswOTAwClN1YmplY3Q6IFtQQVRDSF0gbnRm
czogcHJldmVudCBtb2RpZmljYXRpb24gb2YgJEV4dGVuZCBzeXN0ZW0gbWV0YWRhdGEKClRoZSAk
RXh0ZW5kIGRpcmVjdG9yeSBjb250YWlucyBzeXN0ZW0gZmlsZXMgc3VjaCBhcyAkT2JqSWQsICRR
dW90YSwgYW5kCiRSZXBhcnNlLiBzaG93X3N5c19maWxlcyBvbmx5IGNvbnRyb2xzIGRpcmVjdG9y
eSBlbnVtZXJhdGlvbiwgc28gaGlkZGVuCnN5c3RlbSBtZXRhZGF0YSByZW1haW5zIHJlYWNoYWJs
ZSBieSBleHBsaWNpdCBwYXRoLiBUaGUgZm9yY2VkCmltbXV0YWJpbGl0eSBwb2xpY3kgc2tpcHMg
ZGlyZWN0b3JpZXMgYW5kIGRvZXMgbm90IHByb3RlY3QgJEV4dGVuZAplbnRyaWVzLCBhbGxvd2lu
ZyBybSAtcmYgJyRFeHRlbmQnIHRvIHJlbW92ZSB0aGVtIGFuZCBtYWtlIGxhdGVyIG1vdW50cwpm
YWlsIHdoZW4gbG9hZF9zeXN0ZW1fZmlsZXMoKSBvcGVucyBGSUxFX0V4dGVuZC4KCk1ha2UgRklM
RV9FeHRlbmQgYW5kIHN5c3RlbSBmaWxlcyByZWNvZ25pemVkIGluICRFeHRlbmQgaW1tdXRhYmxl
CmluZGVwZW5kZW50bHkgb2Ygc3lzX2ltbXV0YWJsZS4gVGhpcyBwcmV2ZW50cyBuYW1lc3BhY2Ug
Y2hhbmdlcyBiZW5lYXRoCiRFeHRlbmQgYW5kIGRpcmVjdCBWRlMgd3JpdGVzIHRvIGl0cyBzeXN0
ZW0tZmlsZSBpbm9kZXMuCgpGaXhlczogZjcyZGYzYTRjMzNiICgibnRmczogbWFrZSBzeXN0ZW0g
ZmlsZXMgaW1tdXRhYmxlIHRvIHByZXZlbnQgY29ycnVwdGlvbiIpClJlcG9ydGVkLWJ5OiB0aGVC
SVQ1IHgzemsgPHgzemtAb3V0bG9vay5jb20+ClNpZ25lZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxs
aW5raW5qZW9uQGtlcm5lbC5vcmc+Ci0tLQogZnMvbnRmcy9maWxlLmMgIHwgIDQgKysrLQogZnMv
bnRmcy9pbm9kZS5jIHwgMTEgKysrKysrKy0tLS0KIGZzL250ZnMvaW5vZGUuaCB8ICAzICsrKwog
MyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL250ZnMvZmlsZS5jIGIvZnMvbnRmcy9maWxlLmMKaW5kZXggN2Q5M2E1MjA1NjZl
Li40OGQxYjEzYjdlMTggMTAwNjQ0Ci0tLSBhL2ZzL250ZnMvZmlsZS5jCisrKyBiL2ZzL250ZnMv
ZmlsZS5jCkBAIC0xODIsNyArMTgyLDkgQEAgc3RhdGljIGJvb2wgbnRmc19pc19mb3JjZWRfaW1t
dXRhYmxlKHN0cnVjdCBpbm9kZSAqdmkpCiB7CiAJc3RydWN0IG50ZnNfaW5vZGUgKm5pID0gTlRG
U19JKHZpKTsKIAotCWlmIChuaS0+bWZ0X25vIDwgRklMRV9maXJzdF91c2VyICYmIFNfSVNSRUco
dmktPmlfbW9kZSkpCisJaWYgKE5Jbm9FeHRlbmRTeXMobmkpIHx8CisJICAgIG5pLT5tZnRfbm8g
PT0gRklMRV9FeHRlbmQgfHwKKwkgICAgKG5pLT5tZnRfbm8gPCBGSUxFX2ZpcnN0X3VzZXIgJiYg
U19JU1JFRyh2aS0+aV9tb2RlKSkpCiAJCXJldHVybiB0cnVlOwogCiAJcmV0dXJuIE5Wb2xTeXNJ
bW11dGFibGUobmktPnZvbCkgJiYKZGlmZiAtLWdpdCBhL2ZzL250ZnMvaW5vZGUuYyBiL2ZzL250
ZnMvaW5vZGUuYwppbmRleCA0ZmJkY2Q0NTk2NTIuLjlkZjZkY2ExMGUxNyAxMDA2NDQKLS0tIGEv
ZnMvbnRmcy9pbm9kZS5jCisrKyBiL2ZzL250ZnMvaW5vZGUuYwpAQCAtMTE2NCw2ICsxMTY0LDcg
QEAgc3RhdGljIGludCBudGZzX3JlYWRfbG9ja2VkX2lub2RlKHN0cnVjdCBpbm9kZSAqdmkpCiAJ
CQkgKi8KIAkJCWV4dGVuZF9zeXMgPSBudGZzX2lzX2V4dGVuZGVkX3N5c3RlbV9maWxlKGN0eCk7
CiAJCQlpZiAoZXh0ZW5kX3N5cyA+IDApIHsKKwkJCQlOSW5vU2V0RXh0ZW5kU3lzKG5pKTsKIAkJ
CQlpZiAobS0+ZmxhZ3MgJiBNRlRfUkVDT1JEX0lTX1ZJRVdfSU5ERVgpIHsKIAkJCQkJaWYgKGV4
dGVuZF9zeXMgPT0gMikgewogCQkJCQkJbmFtZSA9IHJlcGFyc2VfaW5kZXhfbmFtZTsKQEAgLTEz
MDcsMTEgKzEzMDgsMTMgQEAgc3RhdGljIGludCBudGZzX3JlYWRfbG9ja2VkX2lub2RlKHN0cnVj
dCBpbm9kZSAqdmkpCiAKIAkvKgogCSAqIFN5c3RlbSBmaWxlcyBzdWNoIGFzICRCaXRtYXAgYW5k
ICRNRlQgYXJlIG1haW50YWluZWQgYnkgdGhlIGRyaXZlcgotCSAqIGl0c2VsZiwgYW5kIHdyaXRp
bmcgdGhlbSBmcm9tIHVzZXJzcGFjZSBjb3JydXB0cyB0aGUgdm9sdW1lLgotCSAqIEFsd2F5cyBt
YWtlIHRoZW0gaW1tdXRhYmxlIHJlZ2FyZGxlc3Mgb2YgdGhlIHN5c19pbW11dGFibGUgb3B0aW9u
LgotCSAqIERpcmVjdG9yaWVzIGFyZSBza2lwcGVkIHNvIHRoZSByb290IGFuZCAkRXh0ZW5kIHN0
YXkgdXNhYmxlLgorCSAqIGl0c2VsZi4gQWx3YXlzIG1ha2UgdGhlbSBpbW11dGFibGUgcmVnYXJk
bGVzcyBvZiB0aGUgc3lzX2ltbXV0YWJsZQorCSAqIG9wdGlvbi4gUHJvdGVjdCAkRXh0ZW5kIGFu
ZCBpdHMgc3lzdGVtIGZpbGVzIHRvbzsgbW9kaWZ5aW5nIHRoZW0KKwkgKiB0aHJvdWdoIHRoZSBW
RlMgY2FuIGNvcnJ1cHQgTlRGUyBtZXRhZGF0YS4KIAkgKi8KLQlpZiAobmktPm1mdF9ubyA8IEZJ
TEVfZmlyc3RfdXNlciAmJiBTX0lTUkVHKHZpLT5pX21vZGUpKQorCWlmIChOSW5vRXh0ZW5kU3lz
KG5pKSB8fAorCSAgICBuaS0+bWZ0X25vID09IEZJTEVfRXh0ZW5kIHx8CisJICAgIChuaS0+bWZ0
X25vIDwgRklMRV9maXJzdF91c2VyICYmIFNfSVNSRUcodmktPmlfbW9kZSkpKQogCQl2aS0+aV9m
bGFncyB8PSBTX0lNTVVUQUJMRTsKIAogCS8qCmRpZmYgLS1naXQgYS9mcy9udGZzL2lub2RlLmgg
Yi9mcy9udGZzL2lub2RlLmgKaW5kZXggN2VhNTJjNTljMDRiLi44YzE5MjliZWJlNDQgMTAwNjQ0
Ci0tLSBhL2ZzL250ZnMvaW5vZGUuaAorKysgYi9mcy9udGZzL2lub2RlLmgKQEAgLTE4Miw2ICsx
ODIsNyBAQCBzdHJ1Y3QgbnRmc19pbm9kZSB7CiAgKiBOSV9IYXNFQQkJCW50ZnMgaW5vZGUgaGFz
IEVBIGF0dHJpYnV0ZS4KICAqIE5JX1J1bmxpc3REaXJ0eQkJcnVubGlzdCBuZWVkIHRvIGJlIHVw
ZGF0ZWQuCiAgKiBOSV9TdHJlYW1VbmxpbmtlZAkJTmFtZWQgc3RyZWFtIGlzIHVubGlua2VkIGJ1
dCBzdGlsbCBvcGVuLgorICogTklfRXh0ZW5kU3lzCQkJSW5vZGUgaXMgYSBzeXN0ZW0gZmlsZSBp
biAkRXh0ZW5kLgogICovCiBlbnVtIHsKIAlOSV9EaXJ0eSwKQEAgLTIwNCw2ICsyMDUsNyBAQCBl
bnVtIHsKIAlOSV9IYXNFQSwKIAlOSV9SdW5saXN0RGlydHksCiAJTklfU3RyZWFtVW5saW5rZWQs
CisJTklfRXh0ZW5kU3lzLAogfTsKIAogLyoKQEAgLTI2NSw2ICsyNjcsNyBAQCBOSU5PX0ZOUyhC
ZWluZ0RlbGV0ZWQpCiBOSU5PX0ZOUyhIYXNFQSkKIE5JTk9fRk5TKFJ1bmxpc3REaXJ0eSkKIE5J
Tk9fRk5TKFN0cmVhbVVubGlua2VkKQorTklOT19GTlMoRXh0ZW5kU3lzKQogCiAvKgogICogVGhl
IGZ1bGwgc3RydWN0dXJlIGNvbnRhaW5pbmcgYSBudGZzX2lub2RlIGFuZCBhIHZmcyBzdHJ1Y3Qg
aW5vZGUuIFVzZWQgZm9yCi0tIAoyLjM0LjEKCg==
--000000000000d638f30660fbcb7d--
