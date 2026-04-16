Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B5381B1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324260; cv=pass; b=SZQL5SKw5ft/ditxcRJ3eRjpbqxsC8CjKNc4i71Ek7e+wX94SCr7/alqlV6K+TyFTUzG/pTZmmYHBwr1PhQdTHmb50JEx4YWZYjS+y0ESaSWrH4mhJaWbXbo3GrizJa9pYjKulUB3CPTyHMNJV/FUqg9cjnDwZdn/zrPvRQYcVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324260; c=relaxed/simple;
	bh=ECUB8q0aCg4XGcpUy/SQPED5RClE4jObeguFxKxFQU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co94X6IK+niEJc1RWatNmEFzwDcbih7BuGvG5K8fW+atZEaM+1KnFPE9opCKyK9L24ZUophlJ9T0PvNytb115DAVSU7/VV6dPPv3mM97ZqEISldGVg/BwRZ+XbaRL92faAS7GO5Ylfdbj12MYduOoWv0QytQxv0o0u7DUc65EIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxtfEe90; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxtfEe90"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so1194752166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 00:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776324257; cv=none;
        d=google.com; s=arc-20240605;
        b=g4ILDiOlxlYE/jYE90NH6ZhFCK5TjVToVqN+yHMsBWVBntd1ZqTTk8VZxeU5dXsu42
         DDH11spqZkUtwtEaMO2PKolkyFjXpfbRcZ5pZghV7SHEe5XwzAPRigktd6JreEtWx5Gr
         anGwS1vGf3oHvzZm010urBRUdV1TMa6hmP1P6bVnJja2BAWA2adPqSiFgZq4SBAPx9mK
         2GvaMj96Mj7VPPZo0wHmn3eRX5FVM4v+myTnr0oiX13vP2wbLDns8zwxtixFQtPGQxuk
         TEV8fiyT0XFPR54aJKZ4fCCULTb/9ipz0QVTkyjvjRZ7qO+9zktwpw08c47/FKjL8IuL
         Ib9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u2C/qsShsmm3HWDhZkZLsQBlhGk6mz10/asru3tcxps=;
        fh=ETp6GOZ/l2+JAZzoCnZwJNID8GrXr3fE/Ue2kR/Pw3M=;
        b=HJLWTm4i6iFjgYvP9SV+CStqsNHXDTQhOnwtsWYLn9c/wX7oBcdNrbNjtmyge2ufia
         VNMIzH1uD2x4c16pvzyfyqKUtZDj8mZ0dNcQFFF9kWuvA/YZY5Rv/+BXYGs+JtG+EFRU
         p1n4Yvf61fvhoJnEVvrZlsn3BKvodicCre3Wb4fhDurB4S7THY20JWeYO8r/VYX/Xf3N
         ggKtAhNEVWAzJy1WPH5WBP45ht5NOXGXAanyugx/ykzdyf2LyikLu7SEzCYJ5j6arVmx
         jSw9KrSkoJX/g6I4aWeG1fGePnkupd93a6U4u/TnbhwXqnpJY1oVdKcRg56ClbOAMl9D
         mwTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776324257; x=1776929057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2C/qsShsmm3HWDhZkZLsQBlhGk6mz10/asru3tcxps=;
        b=bxtfEe90AsCSH0ML6DibsICLg2dbYPMGtCmxU8fX/XAts/SyAbWCp8WCRDQnDeOHjK
         eQGtiuj1rl1dtnHwpOn5Jy8v2tzqZLkeB14HRJFqxbh5rcGsz+nNyZuCzmm4OChZQ4DP
         3kOlGc9uybzi4BlEPphw+LP3+fexGVPaZSAYm4zyEm3gagmKCd2Yqiji+moBQcS+sCV8
         ZOYIuGDpDXsdOQOmpzcNNGS4EhDUF3ijODcsynAuFy+gB+RjQj9ziIaxjT4Evy7MqMFo
         06TMbPavmZ+o+/RhY4FxUML471J8/XeMZos3mkuZ6xbdw8lykKKx1GKV+WphbTXAOTpS
         Haxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776324257; x=1776929057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2C/qsShsmm3HWDhZkZLsQBlhGk6mz10/asru3tcxps=;
        b=EJ/wrb+shS76QsA/5z6hpG4WYvL/yULoTZ8OR7kSxN+jbWHafYfZObMzDq1zw6MCNj
         S381IG5t/c0b8dzYXxHtlGwEYhdkw51hbPit9+hlKKciYlehVQaRTg3KB0abdW6EkRxT
         jmw+eVFdRTGq1YjiuF0bsHi9bBoWOTD41iP+xcSh4B/NgBjgoRH8A8nsTJF1y4xKBGu3
         2A3iqm8u505SQrdarQkzEw5lMz9S6zUbn4dClWJVZkGboIieyNvrnXBAacXfr+qfPZn2
         Wj96Oi4BW8e0uLIzMx6S4dxabwKowjgtwd+CExBVUXuILh1hsg/chT2kploNfueWWHVU
         ebzw==
X-Forwarded-Encrypted: i=1; AFNElJ8j2vqYusioxagW+hYtKh40DamagwIoc2wfShpKpCvlNh0ODFe6yAFmP52M9yvS9blv2+7oWGqU3TRp+KKK@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOs4J8PGXY7E3RswoOTBZ6mNrD5EQYaxSaAxiUj1i7tjLWkfR
	KePlp41Ic/ouv7TwGcvNhYbzNB78xFjTstTz2pC3yatzMnv0ajlHqjqrQfdIXqnXwJOQTO5DUJ4
	A5szIKncQqv2lm5j6+5P7DOS5KQAi1hg=
X-Gm-Gg: AeBDieueFEI0bJZ3otu8O895G5Q90DjYiiraf7R/mvcKhAWp2ht1KV6BJsAfl6oci1Z
	aIK0yzdUVk7GFsXmUBzbS3oBUPd4h5P4x7PtUtbKXinZ8WxEAxUSgjmLBbvJg+sSnYC+OnGSqA5
	sXYetsYTq+IuiRNFgYVPx3BK0A3nw9AoAMQ8GJCFV673sgQT7ssPOx6nKOYvsffijIdksL7jWXn
	WXKzvQH5c8S+zkZQPZtYQSnHTG9rQ9w+5z1L9DbILMCi+USks0ObOGd1wEQ0VgEkqoL74mMeqLJ
	XVaT1vOhNzbJ+/KU7/c3VhTuKrgqcaffG6Ecj9VLAY2AlUYmdQWP
X-Received: by 2002:a17:907:6ea7:b0:b9d:61c7:2343 with SMTP id
 a640c23a62f3a-b9d724ec21cmr1388021966b.10.1776324257065; Thu, 16 Apr 2026
 00:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
In-Reply-To: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Apr 2026 09:24:04 +0200
X-Gm-Features: AQROBzDSrfDQcFz2WPHHHPGV1Lpy5R2aEp9xCRrhWW6cRqfeFGqFFuLTJbo-54U
Message-ID: <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: Nikolay Amiantov <ab@fmap.me>
Cc: fuse-devel@lists.sourceforge.net, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, fuse-devel@lists.linux.dev
Content-Type: multipart/mixed; boundary="00000000000059860a064f8eb8c7"

--00000000000059860a064f8eb8c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[CC new fuse-devel list and fsdevel]

On Wed, Apr 15, 2026 at 7:24=E2=80=AFPM Nikolay Amiantov via fuse-devel
<fuse-devel@lists.sourceforge.net> wrote:
>
> Hi everybody,
>
> I've recently encountered a weird issue with JuiceFS [1], a network FS
> which uses FUSE. tl;dr: when a file was being slowly appended, a reader
> of the same file on another host would periodically read a block of zero
> bytes instead of the actual data.
>
> While researching it I've built an MRE; turns out, this issue can be
> triggered on a fresh kernel and libfuse3 with:
> * A test FUSE FS which exposes a slowly growing file containing only
> 0xAA bytes, with disabled kernel stat cache and no handling of the read
> cache (so, with automatic cache handling by the kernel);
> * A script which reads the file sequentially checking for zeroes, while
> also hammering `os.stat` on the same file from separate threads.
>
> I couldn't find any prior discussion of this issue. I'm suspecting a
> kernel bug; sadly, I have no prior experience with the kernel-side FUSE
> subsystem, but with a lot of (disclosure) LLM help explaining the FUSE
> module and the kernel read cache architecture, I think I understand what
> happens and implemented a partial fix which, to me, makes sense.
>
> If I understand correctly, a full fix is impossible without VFS-level
> locking changes; I've actually managed to reproduce a similar issue in
> NFS [2]; this may be applicable to any network FS which may increase an
> inode size outside of `read`/`write`s.
>
> All my code, experiments and a kernel patch which makes the issue less
> frequent (but still existing) can be found at
> https://github.com/abbradar/fuse_growtest
>
> Any help checking my findings and pointing me in the right direction is
> appreciated!
>
> Thanks for your help,
> Nikolay.
>
> [1]: https://github.com/juicedata/juicefs/issues/5038
> [2]: https://github.com/abbradar/nfs_stale_cache_test
>
>

Hi Nikolay,

Your question is related to kernel filesystem and you also mention NFS,
so added fsdevel list for attention of relevant developers which are
not subscribed
to the fuse-devel list.

Also attaching your patch here for convenience.

Thanks,
Amir.

--00000000000059860a064f8eb8c7
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-fuse-fix-stale-page-cache-data-race-on-file-growth.patch"
Content-Disposition: attachment; 
	filename="0001-fuse-fix-stale-page-cache-data-race-on-file-growth.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mo15gofr0>
X-Attachment-Id: f_mo15gofr0

RnJvbSAwMDdjODUzMWMwNjQ0ZTI1OTMyMWI4ZTFiMTUxMDAzNDM5Zjc1ZWJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWtvbGF5IEFtaWFudG92IDxhYkBmbWFwLm1lPgpEYXRlOiBX
ZWQsIDE1IEFwciAyMDI2IDA3OjI4OjE5ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gZnVzZTogZml4
IHN0YWxlIHBhZ2UgY2FjaGUgZGF0YSByYWNlIG9uIGZpbGUgZ3Jvd3RoCgpXaGVuIGEgRlVTRSBz
ZXJ2ZXIgcmVwb3J0cyBhIGxhcmdlciBmaWxlIHNpemUgdmlhIGxvb2t1cCBvciBnZXRhdHRyLApm
dXNlX2NoYW5nZV9hdHRyaWJ1dGVzKCkgdXBkYXRlcyBpX3NpemUgYmVmb3JlIGludmFsaWRhdGlu
ZyBzdGFsZSBwYWdlCmNhY2hlIGVudHJpZXMuIFRoZSBwYWdlIGJlZm9yZSB0aGUgRU9GIGNvbnRh
aW5zIGtlcm5lbC1nZW5lcmF0ZWQKemVyby1maWxsIGJleW9uZCB0aGUgb2xkIGlfc2l6ZS4gT25j
ZSBpX3NpemUgaXMgaW5jcmVhc2VkLCB0aGVzZSB6ZXJvZXMKYmVjb21lIHZpc2libGUgdG8gY29u
Y3VycmVudCByZWFkZXJzIGJlZm9yZSB3ZSBpbnZhbGlkYXRlIHRoZSBjYWNoZQpsYXRlciBvbi4K
CkZpeCB0aGlzIGJ5IGV2aWN0aW5nIHRoZSBhZmZlY3RlZCBwYWdlIGJlZm9yZSB1cGRhdGluZyBp
X3NpemUuIFRoZSBmaS0+bG9jawpzcGlubG9jayBpcyBkcm9wcGVkIGJlZm9yZSB0aGUgaW52YWxp
ZGF0aW9uICh3aGljaCBjYW4gc2xlZXApLCB0aGVuCnJlYWNxdWlyZWQgdG8gcmVjaGVjayBGVVNF
X0lfU0laRV9VTlNUQUJMRSBiZWZvcmUgdXBkYXRpbmcgaV9zaXplLgotLS0KIGZzL2Z1c2UvaW5v
ZGUuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9m
cy9mdXNlL2lub2RlLmMgYi9mcy9mdXNlL2lub2RlLmMKaW5kZXggNzM1YWJmNDI2YTA2Li42MWFl
MGY5NGU0ZGMgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvaW5vZGUuYworKysgYi9mcy9mdXNlL2lub2Rl
LmMKQEAgLTMzNCw4ICszMzQsNDIgQEAgdm9pZCBmdXNlX2NoYW5nZV9hdHRyaWJ1dGVzKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmdXNlX2F0dHIgKmF0dHIsCiAJICogZXh0ZW5kIGxvY2Fs
IGlfc2l6ZSB3aXRob3V0IGtlZXBpbmcgdXNlcnNwYWNlIHNlcnZlciBpbiBzeW5jLiBTbywKIAkg
KiBhdHRyLT5zaXplIGNvbWluZyBmcm9tIHNlcnZlciBjYW4gYmUgc3RhbGUuIFdlIGNhbm5vdCB0
cnVzdCBpdC4KIAkgKi8KLQlpZiAoIShjYWNoZV9tYXNrICYgU1RBVFhfU0laRSkpCi0JCWlfc2l6
ZV93cml0ZShpbm9kZSwgYXR0ci0+c2l6ZSk7CisJaWYgKCEoY2FjaGVfbWFzayAmIFNUQVRYX1NJ
WkUpKSB7CisJCS8qCisJCSAqIFdoZW4gYSBmaWxlIGdyb3dzIHJlbW90ZWx5LCB0aGUgcGFnZSBz
dHJhZGRsaW5nIHRoZSBvbGQKKwkJICogRU9GIGNvbnRhaW5zIHplcm8tZmlsbCBiZXlvbmQgb2xk
c2l6ZS4gIFRob3NlIHplcm9lcyBhcmUKKwkJICogdmFsaWQgd2hpbGUgaV9zaXplIGVxdWFscyBv
bGRzaXplICh0aGV5IGFyZSBiZXlvbmQgRU9GKSwKKwkJICogYnV0IGJlY29tZSBzdGFsZSBvbmNl
IGlfc2l6ZSBpcyBpbmNyZWFzZWQ6IGNvbmN1cnJlbnQKKwkJICogcmVhZGVycyB3b3VsZCBzZWUg
emVyb2VzIGluc3RlYWQgb2YgdGhlIGRhdGEgd3JpdHRlbiBieQorCQkgKiB0aGUgcmVtb3RlIGhv
c3QuIEV2aWN0IHRoZSBhZmZlY3RlZCBwYWdlKHMpIEJFRk9SRSB1cGRhdGluZworCQkgKiBpX3Np
emUuICBBbnkgcmVhZGVyIHRoYXQgcmUtcG9wdWxhdGVzIHRoZSBjYWNoZSBiZXR3ZWVuIHRoZQor
CQkgKiBpbnZhbGlkYXRpb24gYW5kIHRoZSBpX3NpemUgdXBkYXRlIHdpbGwgaXNzdWUgYSBmcmVz
aAorCQkgKiBGVVNFX1JFQUQgd2l0aCB0aGUgbmV3IGRhdGEgdGhlcmUuCisJCSAqCisJCSAqIFRo
ZXJlIGlzIGEgcmVzaWR1YWwgcmFjZTogYSByZWFkZXIgdGhhdCBoYXMKKwkJICogYWxyZWFkeSBv
YnRhaW5lZCBhIGZvbGlvIHJlZmVyZW5jZSB2aWEgdGhlIGxvY2tsZXNzCisJCSAqIGZpbGVtYXBf
Z2V0X3JlYWRfYmF0Y2goKSBidXQgaGFzIG5vdCB5ZXQgcmVhY2hlZCB0aGUKKwkJICogaV9zaXpl
X3JlYWQoKSBpbiBmaWxlbWFwX3JlYWQoKSB3b3VsZCBob2xkIGEgcmVmIHRoYXQKKwkJICogcHJl
dmVudHMgaW52YWxpZGF0ZV9pbm9kZV9wYWdlczJfcmFuZ2UoKSBmcm9tIGV2aWN0aW5nCisJCSAq
IHRoZSBmb2xpby4gIFRoZSByZWFkZXIgd291bGQgdGhlbiB1c2UgdGhlIG5ldyBpX3NpemUKKwkJ
ICogKHJlYWQgYWZ0ZXIgb3VyIGlfc2l6ZV93cml0ZSkgdG8gY29weSBzdGFsZSBkYXRhLgorCQkg
Ki8KKwkJaWYgKFNfSVNSRUcoaW5vZGUtPmlfbW9kZSkgJiYgYXR0ci0+c2l6ZSA+IG9sZHNpemUp
IHsKKwkJCXNwaW5fdW5sb2NrKCZmaS0+bG9jayk7CisJCQlpbnZhbGlkYXRlX2lub2RlX3BhZ2Vz
Ml9yYW5nZShpbm9kZS0+aV9tYXBwaW5nLAorCQkJCQkJICAgICAgb2xkc2l6ZSA+PiBQQUdFX1NI
SUZULAorCQkJCQkJICAgICAgKGF0dHItPnNpemUgLSAxKSA+PiBQQUdFX1NISUZUKTsKKwkJCXNw
aW5fbG9jaygmZmktPmxvY2spOworCQkJLyoKKwkJCSAqIFJlY2hlY2sg4oCUIGEgd3JpdGUgb3Ig
dHJ1bmNhdGUgbWF5IGhhdmUgc2V0CisJCQkgKiBGVVNFX0lfU0laRV9VTlNUQUJMRSB3aGlsZSB3
ZSBkcm9wcGVkIHRoZSBsb2NrLgorCQkJICovCisJCQlpZiAoIXRlc3RfYml0KEZVU0VfSV9TSVpF
X1VOU1RBQkxFLCAmZmktPnN0YXRlKSkKKwkJCQlpX3NpemVfd3JpdGUoaW5vZGUsIGF0dHItPnNp
emUpOworCQl9IGVsc2UgeworCQkJaV9zaXplX3dyaXRlKGlub2RlLCBhdHRyLT5zaXplKTsKKwkJ
fQorCX0KIAlzcGluX3VubG9jaygmZmktPmxvY2spOwogCiAJaWYgKCFjYWNoZV9tYXNrICYmIFNf
SVNSRUcoaW5vZGUtPmlfbW9kZSkpIHsKLS0gCjIuNDcuMAoK
--00000000000059860a064f8eb8c7--
