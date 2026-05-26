Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E4CA45
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754150; cv=none; b=e1WZFjV9Cai7MVAX0ORnL/dvTCTWRuabuTo4oEx0M9U71kBOqABFypp7ykFwZqULkPpXpPkHPsizVgOV+6S8GRtABEtLmRLatIZ1bkrtLOfR3+t0RB4wfFnINQJChcr8MLPheQq/og/jdCAJPiDmrkCwWMVcsVd3psvbbamMBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754150; c=relaxed/simple;
	bh=8KgsicojM4NVmpBWFJpdGQKD+Dx1c4rqlwuaelVkhrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrFE+Wo4bbokJdrF4NBVUUcYv8JnVKtJMD3sIpq9rKeDt9nwQUfNpXMlaoVrk7lWCUYglNvoDzT0gm9yYsmQ4NsIdwFJY1d/ptN2QIM2aui4GpjQiIgfQv46ZuJp9WDhHPXbD03dRt/4S2bsBW3FcpsW79fyFApPfViab1rU/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/eUPlXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/eUPlXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40E21F000E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 00:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779754149;
	bh=fjgN6GJ98kKnpdb2h84CRduc0nNGjjrsFkjvMQUhog8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E/eUPlXjJS8JE2QZTqxhxzZXgYd70O9ueds4c6NiJ6Yv37cE009GQDyJWm+DyVUpv
	 nXlbH6ujJQEsvqe1PoAAx+bsMiJC5srkOR8cjGzOCfdtUCG1NgQs8JEEtvtVy80u/J
	 IAAPif9XfoFtDq1ynBYVd9qpAXJBMkMOFi3YVblfzLsyEog0aBylUOmgLzmkIJmX7L
	 1Yjoh6aGaiMaXoQf5/rBBg4badA63xoRzFUarD8zxZAfsSqNxvG2JxmTcZ6RACbEAo
	 6FftFoNjUmpqz7FasrC8eihGyKQesD+JQL2fA3zxUHeRbX8zo9htzyuQT3jfJ9k6K6
	 /keuWOFaZ8iNw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd56d108454so1812074566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 17:09:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9o073BcNbd2mdzQtvaymW+AwlnzV3WkYG0Lla0vzKmVO9LOybhWcunM5jBhxTqu4sF1bYY8YWJYeVkj03a@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcHDaYqCrptEpGUiE/KaKv+XOHDrAfgSS1ThENCkWKxOKCymh
	hXWW/7nVnjKmQ638FeII2J1IlWeqpoZviCFa2fEwtxcYOsCcMBdu9BqUXQB90umj4JKF0kq3nXO
	w3X/sP6eUCMYxsuvpUn6eEPPFJnZZ6wA=
X-Received: by 2002:a17:906:8457:b0:bdc:a4ff:ca72 with SMTP id
 a640c23a62f3a-bdd269b69e0mr699258566b.45.1779754147602; Mon, 25 May 2026
 17:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524054238.3129288-3-charsyam@gmail.com> <20260525163254.240238-1-charsyam@gmail.com>
In-Reply-To: <20260525163254.240238-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 26 May 2026 09:08:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_HQApC7kpRKNbpzvUy=yWX+UP4unNX-w5rdFyn4SoAkw@mail.gmail.com>
X-Gm-Features: AVHnY4LFcEAXWCNUcI4ngLxm2KIOptMshhaxx0rvCnihUhP_gSK46m5qevd5YaE
Message-ID: <CAKYAXd_HQApC7kpRKNbpzvUy=yWX+UP4unNX-w5rdFyn4SoAkw@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: validate resident attribute values on lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:33=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> =
wrote:
>
> ntfs_attr_find() and ntfs_external_attr_find() check that generic
> resident attribute values fit in their attribute records and that
> fixed-size resident values are large enough. For variable-length resident
> formats, however, the fixed part is not enough: embedded length fields
> can still point callers past the resident value.
>
> A crafted image can set a small resident $FILE_NAME value_length while
> leaving file_name_length large. Callers then trust file_name_length and
> read past the resident value when converting or comparing the name. This
> was reproduced with a crafted image under KASAN as a slab-out-of-bounds
> read from the kmalloc-1k MFT record copy. The stack included
> ntfs_lookup(), ntfs_iget(), ntfs_read_locked_inode(), ntfs_attr_name_get(=
),
> ntfs_ucstonls(), and utf16s_to_utf8s().
>
> Add a shared resident attribute value validator and use it before a
> lookup path can return an attribute, including the AT_UNUSED enumeration
> case where callers inspect returned attributes directly. The helper
> validates resident value bounds, minimum value sizes, and variable-length
> $FILE_NAME and $INDEX_ROOT fields, while preserving the fixed-size
> checks for attributes such as $VOLUME_INFORMATION and $EA_INFORMATION.
> Log corruption at the rejection point with the attribute name where
> known.
>
> Reject non-resident $FILE_NAME records too: the format requires
> $FILE_NAME to be resident and callers treat returned records as
> resident.
>
> Type-specific format validation for $VOLUME_NAME is intentionally not
> added to this helper, even though $VOLUME_NAME is a variable-length
> resident attribute. Existing callers such as ntfs_write_volume_label()
> treat a failed AT_VOLUME_NAME lookup as an absent label and
> unconditionally add a new record afterwards. If the helper rejected
> odd-length labels at lookup time, the corrupt record would stay in
> place and the caller would append a new record next to it, producing
> two $VOLUME_NAME attributes on disk. Caller-side cleanup must precede
> any lookup-time rejection of malformed $VOLUME_NAME payloads, so the
> type-specific check is left for a follow-up patch. The generic resident
> bounds checks (value_offset / value_length / attr_len) still apply to
> $VOLUME_NAME, and its entry in the type-name table is kept so that
> those failures log with the attribute name.
>
> Fixes: 6ceb4cc81ef3 ("ntfs: add bound checking to ntfs_attr_find")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
> Patch 1/2 of the previous series ("ntfs: free link name from
> ntfs_name_cache") has been applied to ntfs-next; this v2 contains only
> the remaining patch, with the resident attribute validation reworked per
> review feedback.
>
> Changes since v1:
> - Refactor resident attribute validation into a shared helper
>   ntfs_attr_value_is_valid() used by both ntfs_attr_find() and
>   ntfs_external_attr_find(), and remove the duplicated inline check
>   from ntfs_external_attr_find().
> - Split out resident header/value bounds extraction into
>   ntfs_resident_attr_value_get(), returning a small view struct so the
>   top-level orchestration reads as: get view -> common min check ->
>   per-type format check.
> - Validate before the AT_UNUSED enumeration path in ntfs_attr_find()
>   can return the attribute to callers that inspect it directly.
> - Reject non-resident $FILE_NAME records: the format requires
>   $FILE_NAME to be resident and callers treat returned records as
>   resident.
> - Extend type-specific validation beyond $FILE_NAME to $INDEX_ROOT
>   (entries_offset / index_length / allocated_size bounds and 8-byte
>   alignment); add $INDEX_ROOT to ntfs_resident_attr_min_value_length().
> - Type-specific format validation for $VOLUME_NAME is intentionally
>   not added; see the commit message for the caller-side reason.
>   Generic resident bounds checks still apply, and the $VOLUME_NAME
>   entry in the type-name table is kept so that those failures log
>   with a readable attribute name.
> - Log corruption at the rejection point with the attribute type name
>   via a new ntfs_attr_type_name() helper, matching the existing
>   attribute-name corruption message in ntfs_attr_find().
Please check xfstests generic/001 test
failure.(https://github.com/namjaejeon/linux-ntfs/actions/runs/26424312505/=
job/77785594232)

FSTYP -- ntfs
570PLATFORM -- Linux/x86_64 runnervmg397c 6.17.0-1013-azure
#13~24.04.1-Ubuntu SMP Wed Apr 15 16:52:17 UTC 2026
571MKFS_OPTIONS -- -q --partition-start=3D0 --sectors-per-track=3D0
--heads=3D0 /dev/loop21
572MOUNT_OPTIONS -- /dev/loop21 /mnt/scratch
573
574generic/001 _check_generic_filesystem: filesystem on /dev/loop20 is
inconsistent
575(see /home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests-e=
xfat/results//generic/001.full
for details)
576Trying to repair broken TEST_DEV file system
577- output mismatch (see
/home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests-exfat/res=
ults//generic/001.out.bad)
578 --- tests/generic/001.out 2025-01-14 04:54:54.000000000 +0000
579 +++ /home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests-e=
xfat/results//generic/001.out.bad
2026-05-26 00:01:44.663029196 +0000
580 @@ -7,3 +7,4 @@
581 iter 4 chain ... check ....................................
582 iter 5 chain ... check ....................................
583 cleanup
584 +rm: cannot remove '/mnt/test/83726/sub': Input/output error
585 ...
586 (Run 'diff -u
/home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests-exfat/tes=
ts/generic/001.out
/home/runner/work/linux-ntfs/linux-ntfs/exfat-testsuites/xfstests-exfat/res=
ults//generic/001.out.bad'
to see the entire diff)
587Ran: generic/001
588Failures: generic/001
589Failed 1 of 1 tests
