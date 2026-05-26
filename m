Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830021CC59
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779757559; cv=pass; b=PrgwElCCkgDiK37HhOr97UqKLB+49L3QFk1j0sfcGijJYbMn4AAdJNZ3m2EN36PEQgwXk5p8VhigcywtuJW7s+JvGYQVASi2yIJS/GlUnpvP/gE+aw3oq/btL6veUtuduU0YHpxIv8YD7/ElObC5Jscxpl9su+YG76IVVuMnmKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779757559; c=relaxed/simple;
	bh=5htiUEtWTtuOfHhuy5D+ckDJ+nC7Lo1FOItPSJ1Wilc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7VK0cWHl7UvAGjIysEo2JIkXTFvXL80rhonOcmqhgLUT6oxJ9ro2qFsAx53cDJwDKleckeA/KgOBElu7tIFBn9eWitnNGYeqLJt/mCRxDjKAHvPwA4u+YGajv+HZAqXzD+k9J/R7WuYz9h6v/PrgKJDox5j3un46Py+SIh9aWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guaO+4q9; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guaO+4q9"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65e81d623bbso622038d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 18:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779757557; cv=none;
        d=google.com; s=arc-20240605;
        b=B+nmV1LCIjD6LodsjecC6cofj9uOTaNOnDcE8QtKQ29cbj/Ef8QdTebtHegi8EKDho
         ZOAdFpskP03v4QAGexg1M6aSrl0P9jWMW+RYXofRar+k/u0Py7ylkTovllxCk0BPZFxW
         nZRE++is7x3/Pve2QElISnl9A3uNZ+AbAeZfR2njcl7PsMG8KfuKe6FWZjiPGda3AKEe
         m+wbF00olpQpVcpEtjiE5ItsmaDlzBj1mDcAqWP2bTBHHQFd4DKGOspQ2DKzVm21U4bT
         XIEbZ9CLpY8mmjEsChsJkiZCFfGlF0KFnJQ4Ow8mHppVs+++E2ZXtjwPFoR0Hz1eALnj
         leUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dyR06HuS3ky0cG4KENeQeMuspo/1o4J5flM7HbeeCz8=;
        fh=p5XShPcbo814D8I5AE0rzjaWM4iILxAdmYrPdMKltqY=;
        b=KIoY2lj8UM66TsESGL7YLa5OdaGAUGpbqXnHkVAj5nGQ+FTnCxOSSrRUabHTJDsbIB
         JcXjqAt82Jh5l2upZ4ISqfAG9ioeNYV8aUtUq8CVJ5PBwad4Vq7VucrVm2zkAa1tdYtZ
         3w5BkCKqUPpYKcCkq2HkUHwvbbaW4szl+jDSbBmWHu8554ovZhgxRn8TD9nYdfgrqmh7
         iupj4EpwYLFEP6t3FZN+lLeY97L3uZCmS9yehZ/2lRx17Dvi4zIri612kTe7z9KTa07v
         q63zBndjpfafLlA2KOvRRCDQBf8UVuxeyZ/ZQJjKmACdaRrI2z4B643fq4e1YASWmpUG
         ROaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779757557; x=1780362357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyR06HuS3ky0cG4KENeQeMuspo/1o4J5flM7HbeeCz8=;
        b=guaO+4q9I9NqML710enfOv/m+9W9O6xO93Xaazw0TJ9103QtSJ9ZslNoqQ8h+zYrIa
         k985/IAq2ctna81JPreNSe/RCmQ8wzPS+gvXF6UHCKqQI5+39djVFnqI4zN86cz1PIjO
         AB4d5ceOhgotXmaRtw74r/11AtruCmB5TlPuw35e6eR0oVSbxfk6wFXzeEVnXpHMFSva
         9z+JWkq6kBYBYS4Ctne7UlEBKITWs21F18m5Q0R1IJjosrQB7e72sDIwFzYC67ux69+H
         EoAwhxzHW+tKOmeZosAv3sRmMOat4iVrB7oUd8wJYUHph+oQAfTeKIZoxL8iu34OPBRX
         pf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779757557; x=1780362357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyR06HuS3ky0cG4KENeQeMuspo/1o4J5flM7HbeeCz8=;
        b=MxIi8r71mSAMbaSK8hQEhsaHnrPYUcKffM9cOO+EbXeQ7E1VoHGlQNbMzG9G1kfYry
         iyy3a4zHwV+L2SgimACS/utArDLzVyhzLwd2kc+7R4+MV6dkD0bfsvUfHeDNfSbU5nlV
         1CR6wUL5/tv17vMgewAxT430m2IBzEUaOSf8wEvq3Jz6nTWwj5mj22MbOFMsTNcqcw1E
         eUH5PoWWgUVxWQwynqGRu+9dDpx4/zfsivTVSNnTRc9H+HI41Nv4gjRhnB+w2KhyghlJ
         9lj4puYccB4gyfgiutOGVjihK7fEX+AAqIT9be/GRevV6KWa090xW1M9mUlU54FjAKCr
         tS0w==
X-Forwarded-Encrypted: i=1; AFNElJ+uRbhlRMylWhZ1dRGIJHtuf8u30RlprkBHoaF1e1yU58bqa8guc1+fbf0w/qzT1CNJdGARZ+9wDeyQPN5u@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfYJ9nyZB50grIEjDm4CNTHWhAeoWQbP2IF7Vd5YylI3Pqu0u
	RPqIRg13/x29WWU+rgQ0xs8iN39aPR/QASuYsdaQrRS+oeLdzGtHDjmJ0Lp6KZK0YEAjQ2jPhCI
	/p6h5QgSJHRTfSMtT1sa2rJ6AygGJx/A=
X-Gm-Gg: Acq92OHr+dtf7tu4Yxpz1lFBA4oLU3GoJIk42AS5mmY05aBI/VijYLldu9VoRoaFUJ/
	agWi/C8DDYnpxlVyZDFokhS1iWFi74JqntSg1p3R5FEQbU74CeSZXE+Ccgh7zFN/XlHPrf6QC4n
	2r1ZxUEFPcqVKhK1Le9LZPpfe0mVy7QkjiPbpnoR1PJZ+t9TwaCCfAr/37Qv5cwAZI5tDAvDQ9O
	B5fnzsOhAO+QbOcEkCC6EmgZVd2pUsAgY5tH0huuFnlxGADc35lddktWuJbCZ974Nzz9foWxgCS
	yBKZAA6H
X-Received: by 2002:a05:690c:7107:b0:7b3:6ff8:70b7 with SMTP id
 00721157ae682-7d3335faaeamr117711937b3.1.1779757557149; Mon, 25 May 2026
 18:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524054238.3129288-3-charsyam@gmail.com> <20260525163254.240238-1-charsyam@gmail.com>
 <CAKYAXd_HQApC7kpRKNbpzvUy=yWX+UP4unNX-w5rdFyn4SoAkw@mail.gmail.com>
In-Reply-To: <CAKYAXd_HQApC7kpRKNbpzvUy=yWX+UP4unNX-w5rdFyn4SoAkw@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Tue, 26 May 2026 10:05:46 +0900
X-Gm-Features: AVHnY4Kic6ktiKgyzPngOa4Gbb0PCjRdW_OfePs2ikbLu-ylqraXky7r8AZ6gdk
Message-ID: <CAMrLSE5izyWrP=t3_7UWjKJTd296fBrdoHZBW3DMMCzwPY9v-Q@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: validate resident attribute values on lookup
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will check it soon. Thanks.

2026=EB=85=84 5=EC=9B=94 26=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 9:09, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, May 26, 2026 at 1:33=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com=
> wrote:
> >
> > ntfs_attr_find() and ntfs_external_attr_find() check that generic
> > resident attribute values fit in their attribute records and that
> > fixed-size resident values are large enough. For variable-length reside=
nt
> > formats, however, the fixed part is not enough: embedded length fields
> > can still point callers past the resident value.
> >
> > A crafted image can set a small resident $FILE_NAME value_length while
> > leaving file_name_length large. Callers then trust file_name_length and
> > read past the resident value when converting or comparing the name. Thi=
s
> > was reproduced with a crafted image under KASAN as a slab-out-of-bounds
> > read from the kmalloc-1k MFT record copy. The stack included
> > ntfs_lookup(), ntfs_iget(), ntfs_read_locked_inode(), ntfs_attr_name_ge=
t(),
> > ntfs_ucstonls(), and utf16s_to_utf8s().
> >
> > Add a shared resident attribute value validator and use it before a
> > lookup path can return an attribute, including the AT_UNUSED enumeratio=
n
> > case where callers inspect returned attributes directly. The helper
> > validates resident value bounds, minimum value sizes, and variable-leng=
th
> > $FILE_NAME and $INDEX_ROOT fields, while preserving the fixed-size
> > checks for attributes such as $VOLUME_INFORMATION and $EA_INFORMATION.
> > Log corruption at the rejection point with the attribute name where
> > known.
> >
> > Reject non-resident $FILE_NAME records too: the format requires
> > $FILE_NAME to be resident and callers treat returned records as
> > resident.
> >
> > Type-specific format validation for $VOLUME_NAME is intentionally not
> > added to this helper, even though $VOLUME_NAME is a variable-length
> > resident attribute. Existing callers such as ntfs_write_volume_label()
> > treat a failed AT_VOLUME_NAME lookup as an absent label and
> > unconditionally add a new record afterwards. If the helper rejected
> > odd-length labels at lookup time, the corrupt record would stay in
> > place and the caller would append a new record next to it, producing
> > two $VOLUME_NAME attributes on disk. Caller-side cleanup must precede
> > any lookup-time rejection of malformed $VOLUME_NAME payloads, so the
> > type-specific check is left for a follow-up patch. The generic resident
> > bounds checks (value_offset / value_length / attr_len) still apply to
> > $VOLUME_NAME, and its entry in the type-name table is kept so that
> > those failures log with the attribute name.
> >
> > Fixes: 6ceb4cc81ef3 ("ntfs: add bound checking to ntfs_attr_find")
> > Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> > ---
> > Patch 1/2 of the previous series ("ntfs: free link name from
> > ntfs_name_cache") has been applied to ntfs-next; this v2 contains only
> > the remaining patch, with the resident attribute validation reworked pe=
r
> > review feedback.
> >
> > Changes since v1:
> > - Refactor resident attribute validation into a shared helper
> >   ntfs_attr_value_is_valid() used by both ntfs_attr_find() and
> >   ntfs_external_attr_find(), and remove the duplicated inline check
> >   from ntfs_external_attr_find().
> > - Split out resident header/value bounds extraction into
> >   ntfs_resident_attr_value_get(), returning a small view struct so the
> >   top-level orchestration reads as: get view -> common min check ->
> >   per-type format check.
> > - Validate before the AT_UNUSED enumeration path in ntfs_attr_find()
> >   can return the attribute to callers that inspect it directly.
> > - Reject non-resident $FILE_NAME records: the format requires
> >   $FILE_NAME to be resident and callers treat returned records as
> >   resident.
> > - Extend type-specific validation beyond $FILE_NAME to $INDEX_ROOT
> >   (entries_offset / index_length / allocated_size bounds and 8-byte
> >   alignment); add $INDEX_ROOT to ntfs_resident_attr_min_value_length().
> > - Type-specific format validation for $VOLUME_NAME is intentionally
> >   not added; see the commit message for the caller-side reason.
> >   Generic resident bounds checks still apply, and the $VOLUME_NAME
> >   entry in the type-name table is kept so that those failures log
> >   with a readable attribute name.
> > - Log corruption at the rejection point with the attribute type name
> >   via a new ntfs_attr_type_name() helper, matching the existing
> >   attribute-name corruption message in ntfs_attr_find().
> Please check xfstests generic/001 test
> failure.(https://github.com/namjaejeon/linux-ntfs/actions/runs/2642431250=
5/job/77785594232)
>
> FSTYP -- ntfs
> 570PLATFORM -- Linux/x86_64 runnervmg397c 6.17.0-1013-azure
> #13~24.04.1-Ubuntu SMP Wed Apr 15 16:52:17 UTC 2026
> 571MKFS_OPTIONS -- -q --partition-start=3D0 --sectors-per-track=3D0
> --heads=3D0 /dev/loop21
> 572MOUNT_OPTIONS -- /dev/loop21 /mnt/scratch
> 573
> 574generic/001 _check_generic_filesystem: filesystem on /dev/loop20 is
> inconsistent
> 575(see /home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests=
-exfat/results//generic/001.full
> for details)
> 576Trying to repair broken TEST_DEV file system
> 577- output mismatch (see
> /home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests-exfat/r=
esults//generic/001.out.bad)
> 578 --- tests/generic/001.out 2025-01-14 04:54:54.000000000 +0000
> 579 +++ /home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests=
-exfat/results//generic/001.out.bad
> 2026-05-26 00:01:44.663029196 +0000
> 580 @@ -7,3 +7,4 @@
> 581 iter 4 chain ... check ....................................
> 582 iter 5 chain ... check ....................................
> 583 cleanup
> 584 +rm: cannot remove '/mnt/test/83726/sub': Input/output error
> 585 ...
> 586 (Run 'diff -u
> /home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests-exfat/t=
ests/generic/001.out
> /home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests-exfat/r=
esults//generic/001.out.bad'
> to see the entire diff)
> 587Ran: generic/001
> 588Failures: generic/001
> 589Failed 1 of 1 tests
