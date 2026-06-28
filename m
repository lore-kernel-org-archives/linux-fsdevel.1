Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6322370A
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782690164; cv=pass; b=O9iV4RyFXZMD5S1fcnPyTAkBc0MRrOHbwWydcRunUl9QtWTWs0hvbs7ZYMyBIqPlupGJS/GuUYdOkKBW1HFx8QO5NqUjaqNrvIug7mzPm8+15LpjgFottvZ//pY88PxoKNR1ypHueDXd5jtxZcT0+CZ3jfr0aHmTTn18TF7UcAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782690164; c=relaxed/simple;
	bh=WkSBiaPgT77wOXHcI1bS01jKi/dOjmDGBwyodGKswSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VB8KcY9cTh9vZDYlz9Auuobznc8/BHz8LgKgtO0oO87tbkEceTi+SQWTML/ngu6VteaOIFsANL5AL64gtd/XsEHJbPdYVu2/ZCCNjks+nhGs0wncxuHcWRlMgZSFD157ghMuxFfalICGHK1s47vrTP5iBEeKfpV3iYb44rWQTeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9tp5MjE; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9tp5MjE"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aea0fff535so2749319e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 16:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782690161; cv=none;
        d=google.com; s=arc-20260327;
        b=DpwoUTzv0GpjKfrbigGRQ+SjXJOIrCwbWrZsFL86h3OB5VM2E07R9UbggVhN/nrIV1
         8R97Msufv2paHweWxyLPELfUV+vJhEmXoSX7Whvs6HtbQdLeFxN6mIAHzDqoYsqaEUTc
         5z2tf4OiYq5NCB/kQytwvApbaJiPw+LkNxKzU2L/ADKLorzslOjdIq6vYA+dEak3aqY2
         N4xlYRLcB2iA1SAg6GUJhS4GDfXIEMg+zdx+nxKS/drD+k+XZ61w4OLJczqSscWtjj+S
         Mmhwitf6PgwtzWWOmvBNfuW08vnZNiJ5W1IDvUOqGmZYW3STiEcUK0IIlmz5uziGIYGa
         TRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WkSBiaPgT77wOXHcI1bS01jKi/dOjmDGBwyodGKswSE=;
        fh=rOhgeqpZ1Zi2aZhquXZOm5UNXAEoIvAsZJZcKjITZnQ=;
        b=VRQ/nKH6D8dommVejQIPL8dN8at8JCqJDkx25g9qhjIN+gJjtVvzXQU83SiNuZ7kTk
         Myv4snRrKaUs1MqCeyWcPdl6sknLYqHHqR9OI63zxIWrxW5gJKlnKF/rXvPmwmSUG5xL
         NBzkVLtiEMHnt3iX/wwlhyDBtZpqphQg5lpLxVnpPxIJhlIjcxp+F++MHYgT8/WShZeH
         keoh7JdokZEqkTKj4vJyNR7cMW//uVj1hDyxCoyBIxMOucSINJUF08Q1ttF5sLjRfUlE
         wwSW4x97qvp3x/EcwvNHx8X5F+ivdELSNUs3i/sky5TZdDqUlb58n5j1gZMcdfCmJk7R
         dFpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782690161; x=1783294961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkSBiaPgT77wOXHcI1bS01jKi/dOjmDGBwyodGKswSE=;
        b=e9tp5MjEvNVRImtLo30cPcMZ0xq66j+lY82z2ZAI/CBvAKAwGZtfzbVzfY46+Ko5OG
         6H4g7x36Sha7H3uSlTDQoeccS55+Cmi39Qo+tlcU5TTSJGmkY7n6oDkbP9oYzCpjt98Q
         jGR9eTpYEJgjSPc1CRf59mY2NG1LznXjJchsS79ZptVNGDAqDFzYmFL6cNgy1in1xOB4
         uqbsLAns4yarV/eZFw0kX04DHc9q7kZUqDzOl6PWesnKdg2scbKwEYt/Ezdg8SBmi4WC
         sM/C6CIiEbuhsy7Pp2+mlylxhaNkoiVCyvfYa1Jv9AxK8/PEOHfAEhwi7VnBS91NgBBS
         jfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782690161; x=1783294961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WkSBiaPgT77wOXHcI1bS01jKi/dOjmDGBwyodGKswSE=;
        b=DxtW9pW11gp5RARMrbEPxTQXQjNpCw/RvfdV8mgt7ybJOaEcfMm3avCwyx+/9tNK4k
         RKJhsn3KBNk31H4lDf8o6OEsUJtH90+9iqqnVJB9l7W7Di9IfQbsMCnQy+gN4eDmC1ss
         lmDXShnYyR0NIiuRK37AL5HCRCMp3x1imRoQwnpHthBNTWCTjBuq7BD2snZE3Vj8TTX0
         mWLANuoiRviONCsZdCZO6mQbr/h22F4FaaEChC+pHaHmjCxnwSwr9fVrwIplkIiwAlRa
         frwxcA15uiB7UrLUEtnf8AHRPLWun4qQRFVcCMWVxAvbwPPNYAgcrBlJuT310ZMb/CNo
         61tQ==
X-Forwarded-Encrypted: i=1; AHgh+RqS6SVZszkRT9SmnX+xqtY5tasIqKR7g5OdHwxUnno8ux0LuUiFOLWmz6mK8WC2N6y2nJaWLatyKXPN1cSi@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1NWHDxQts0Q0hh3XB5frsjJCtK9j2Lm2rAVauB3XiWtdGsGt
	RtXN2DioBqoFhviETzgPyOaQoa98maInhqWzMIwZPG2Egyod/rpag1TpEw9y0EOqkpZ+kWTj2T9
	XHq9Ewbn8csoyz54mX9Mb83IBD2llttuxgnz+
X-Gm-Gg: AfdE7cn2UQ9HBAlgzd3dPcSENNFKN5RKc2g3eJypRfBxxUq5KqRGint2VTUQluIwKMo
	Bc0VX1XEKkn+K/qNgnYFctcXcWEXQyBuXhL5OwLTkfzCzOgAgzqjSvoFJ0dy1oSFeZYzBVqTBET
	b72bw+u/0bfcVziNGTawXkKs5qvLS/4brjoP/oL9fS02RAJZmyph6JVCRLkjO0xggwN6b+yHbdl
	Op3CeiqNDcTqncRsghQUbLKiUTscf63CG30ho+UtWqzRxJkGbIIMlVCwmYj9/sQygVhP/lQ
X-Received: by 2002:ac2:4bd3:0:b0:5ae:b01a:d215 with SMTP id
 2adb3069b0e04-5aeb01ad289mr1267555e87.5.1782690160832; Sun, 28 Jun 2026
 16:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f751705-ca48-48c9-9120-a3829d45e1f8@bakabaka9.tech>
In-Reply-To: <1f751705-ca48-48c9-9120-a3829d45e1f8@bakabaka9.tech>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 29 Jun 2026 08:42:28 +0900
X-Gm-Features: AVVi8CdffwqeD01CwCofEDzBXPURAfJpTFfhDmc4NLjN8j73sRo33TciK7H1Duc
Message-ID: <CANFS6bbEztmGsa8phoCe1mzeW=R2zQ_-9C8ibT9XJk5jGg3jRQ@mail.gmail.com>
Subject: Re: [REPORT] fs/ntfs: out-of-bounds / use-after-free read in
 ntfs_index_walk_down, via crafted directory index, readdir
To: Bakabaka_9 <baka9@bakabaka9.tech>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This issue has already been mitigated in v7.2-rc1.

The root cause has been addressed by ntfs_index_entries_inconsistent(),
which validates that every entry stays within the index_end bounds.

The patch will be backported to v7.1.

Could you please try to reproduce this on v7.2-rc1 and let us know if
the issue is still reproducible?

2026=EB=85=84 6=EC=9B=94 28=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 4:52, B=
akabaka_9 <baka9@bakabaka9.tech>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Tree: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
> Affected: fs/ntfs (the in-kernel NTFS merged in the 7.1 cycle; NOT fs/ntf=
s3)
> Version: v7.1-rc5 (commit e7ae89a0c97c "Linux 7.1-rc5")
>
> Summary
>
> A crafted NTFS directory index triggers an out-of-bounds / use-after-free=
 READ in ntfs_index_walk_down() during readdir(). The index-tree traversal =
helpers ntfs_index_next() / ntfs_index_walk_down() advance to the next inde=
x entry and read its child VCN before validating that the entry lies within=
 the index block. With a corrupted entry length the traversal pointer steps=
 past the index block into an adjacent (and, depending on timing, freed) sl=
ab object, and the kernel dereferences it.
>
> Reproducible deterministically under KASAN; mounting and listing a malici=
ous image is sufficient. Reachable by anyone able to mount an NTFS image (r=
emovable-media automount as root on desktops that route NTFS to this driver=
; a user namespace + mount capability; etc.).
>
> Impact
>
> Confirmed, with KASAN evidence:
>
> Out-of-bounds read and use-after-free read of kernel slab memory (kmalloc=
-4096) -> kernel memory disclosure / KASLR defeat.
> Denial of service (oops / BUG) on a range of corrupted images.
>
> The contents of the read-back object are attacker-influenceable: spraying=
 System V message bodies (kmalloc-4096) into the freed slot during the moun=
t/list window makes the dereferenced VCN take an attacker-chosen value (ver=
ified: spray byte 0xMM -> VCN 0xMM..MM -> ntfs_ib_read pos =3D VCN<<bits).
>
> We specifically investigated whether this can be turned into a controllab=
le write (to assess privilege escalation). It cannot, on this path: in ntfs=
_readdir() the write target ictx->ib is only ever freshly kvzalloc'd (index=
.c:1980), re-read in place, or kfree()'d-and-NULLed (walk_up, index.c:2031)=
. The dangling/out-of-bounds pointer is exclusively the read cursor entry. =
We confirmed this dynamically (57344 sprayed objects read back, 0 overwritt=
en, 0 write-type KASAN reports). So the realistic impact is kernel info-lea=
k + DoS, not a self-contained LPE.
>
> CVSS 3.1 (info-leak + DoS, attacker-supplied image, local/automount deliv=
ery): AV:L/AC:L/PR:N/UI:R/S:C/C:H/I:N/A:H -> 7.0 (High)
>
> KASAN report
>
> BUG: KASAN: use-after-free in ntfs_index_walk_down+0x167/0x230 Read of si=
ze 8 at addr ffff8881060e01ea by task ls/81 CPU: 0 ... 7.1.0-rc5 #2 Call Tr=
ace: ntfs_index_walk_down+0x167/0x230 fs/ntfs/index.c:1978 ntfs_index_next+=
0x9a/0x1c0 fs/ntfs/index.c:2117 ntfs_readdir+0x86f/0x1150 iterate_dir+0xe9/=
0x250 __x64_sys_getdents64+0xec/0x1b0 do_syscall_64+0xf9/0x540
>
> A second, very similar splat is reachable at the same site as "slab-out-o=
f-bounds in ntfs_index_walk_down+0x167" (the same cursor stepping just past=
 the end of a still-allocated block instead of into a freed one).
>
> ntfs_index_walk_down+0x167 corresponds to the VCN load:
>
> fs/ntfs/index.c:1978 vcn =3D ntfs_ie_get_vcn(entry);
>
> and ntfs_ie_get_vcn() reads 8 bytes at entry + entry->length - 8:
>
> fs/ntfs/index.c:273-283 static __le64 *ntfs_ie_get_vcn_addr(struct index_=
entry *ie) { return (__le64 *)((u8 *)ie + le16_to_cpu(ie->length) - sizeof(=
s64)); }
>
> Root cause
>
> The traversal advances and dereferences before bounds-checking.
>
> ntfs_index_next() computes the next sibling purely from the (attacker- co=
ntrolled) on-disk length and immediately dereferences it:
>
> fs/ntfs/index.c:2105 next =3D (struct index_entry *)((char *)ie + le16_to=
_cpu(ie->length)); fs/ntfs/index.c:2107 flags =3D next->flags; fs/ntfs/inde=
x.c:2110 if (flags & INDEX_ENTRY_NODE) fs/ntfs/index.c:2117 next =3D ntfs_i=
ndex_walk_down(next, ictx);
>
> ntfs_index_walk_down() then reads the child VCN of that unvalidated entry=
:
>
> fs/ntfs/index.c:1978 vcn =3D ntfs_ie_get_vcn(entry); /* entry + len - 8 *=
/
>
> A correct per-entry bounds check does exist (ntfs_index_entry_inconsisten=
t(), fs/ntfs/index.c, which verifies ie_start <=3D ie and ie + ie->length <=
 ih + index_length), and ntfs_readdir() even calls it =E2=80=94 but only on=
 the result, one step too late:
>
> fs/ntfs/dir.c:924 next =3D ntfs_index_next(next, ictx); /* derefs first *=
/ ... fs/ntfs/dir.c:933 if (ntfs_index_entry_inconsistent(ictx, vol, next, =
...))
>
> By the time line 933 runs, ntfs_index_next()/ntfs_index_walk_down() have =
already dereferenced next/entry at index.c:2107 and index.c:1978.
>
> For comparison, the classic lookup path open-codes the right check before=
 each dereference while iterating entries:
>
> fs/ntfs/dir.c:390-399 (bounds-checks ie against index_end every iteration=
)
>
> The block-level check ntfs_index_block_inconsistent() (fs/ntfs/index.c, r=
un inside ntfs_ib_read) only validates magic/VCN and index_length <=3D allo=
cated_size <=3D block_size; it does NOT validate individual entry lengths, =
so a block can pass it yet contain an entry whose length walks the cursor o=
ut of the block.
>
> Suggested fix
>
> Validate each entry against the current index block before dereferencing =
it in the traversal helpers:
>
> In ntfs_index_next(), after computing next (index.c:2105) and before read=
ing next->flags, verify next lies within the index block and that next + ne=
xt->length stays within ih + index_length (i.e. call ntfs_index_entry_incon=
sistent() / an inline bounds check there).
> In ntfs_index_walk_down(), validate entry before ntfs_ie_get_vcn(entry) (=
index.c:1978), since ntfs_ie_get_vcn() dereferences entry + len - 8.
> Consider having ntfs_ib_read()/ntfs_index_block_inconsistent() reject blo=
cks whose entry chain does not exactly tile [entries_offset, index_length),=
 so corrupted intra-block lengths are caught at read time.
>
> Reproduction
>
> Tested in QEMU/KVM, x86-64, CONFIG_KASAN=3Dy, v7.1-rc5.
>
> Build a clean image and apply a deterministic mutation: mkntfs -F -s 512 =
-p 0 -H 0 -S 0 <16MiB file> # base.ntfs mutate base.ntfs poc.ntfs 1244 # fl=
ips 8..31 metadata bytes (mutate.c and the prebuilt base.ntfs/poc.ntfs are =
attached.)
>
> In the guest: mount -t ntfs -o loop,ro poc.ntfs /mnt ls -R /mnt -> KASAN =
use-after-free / slab-out-of-bounds read in ntfs_index_walk_down+0x167 (dur=
ing getdents64).
>
> The PoC image (poc.ntfs), the clean base (base.ntfs), the mutator (mutate=
.c), the heap-spray / read-back verifier used for the impact analysis (wpro=
of.c), and the full KASAN logs are attached / available on request.
>
> Disclosure
>
> Found via local fuzzing/auditing (by AI) as authorized security research.=
 No prior public disclosure. Happy to test patches against the reproducer. =
Please advise whether you would like a CVE requested or prefer to handle as=
signment.
>
> -- Bakabaka_9 (baka9@bakabaka9.tech)
>
>


--=20
Thanks,
Hyunchul
