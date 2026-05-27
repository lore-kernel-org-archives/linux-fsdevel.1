Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A155330337
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925707; cv=none; b=LJN3mPG2cEEgjwgS+XxvIi2vE/i2fQZVJK/iG0XNcDzJgvaOtprtE1y9Ug0TlgCho01MCt2wUt8D6/Ua8eM43S0edTxNl79yOxGhugLIXb0vZ359hpyzkhDwseo58Kr0nzyoEUzH6CrzxnD9DI8lisQw3H0GIE/MuuxELg/W0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925707; c=relaxed/simple;
	bh=09Lva0gnpEcxLA8oADqQJpsXrmXuWVxQk7f4dLX8Vvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EY2NzT7JhQkNVFw5hgTScsDIx+akZHHcFh24qf05IWSSUsyRY/uU13VCI8UhwFCHdirIYfiI/6gW+sYtJjS9c1Q4FkLYf/6aU9GkAaYbYsQR4ehmD1md9RZHrVrjHl6JUMzEzSv10UuKTJWh8uh24Pnqq7Fuoae8tHOBBWyAb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEQyVUzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEQyVUzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B031F00A3D
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925705;
	bh=sTujvP5ma1kjzMbf1xHQzckZSAV/C9+6cbGhO9rvGc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hEQyVUzSJIsI6+RVupWX5R/HKuBY0A8+4PjU1ZKxqDqkdtc0/6UKj2KaH5cEPpIjo
	 aKulz0Qy5wZ8tO0EFNBoIph7HDJMdttzYR3v+zG+fPRFxtr0dMkTvuJFfYNYmMvCv/
	 PT+QTQmnhDR4E3944P7XeHggU1fgk+Ez7YIjNQfnf0X0EL6KWQEg5svTs4p9yFV/gA
	 wkOY/6qPdhQSKj77DyZRld5FlMDfCCbX3L0Q4uXt3GZHpqgZbcDJxiK0oaPjfZNWKe
	 Qghn1RdIYx+Nue75TpJzKSHFkEVbZ9LX6S55KiqDsapuKa1/ieG9WBhXvusiFPSM2R
	 G48Lh947szqnQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so642093a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 16:48:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+cb5oKeYwkDM9MlQHA0jlXBaAsTZXZ/ebiLfuleEhUJkwfHVlCOpm2BPzIZhB+N9StQIT29U5ZLk/UH9SW@vger.kernel.org
X-Gm-Message-State: AOJu0YyRH3yAJ0OuQM+APukDLXOU3QTqcgL9orJINDS/KLUYKQ2jNw5J
	QWAx7AQS4FIC3pJCCLMOsiTLLOBF+gJpCt87NKBbBhAHONhImnuj5OMfSHPGKS6PcVFiHiYqfYT
	LxyVAzdGgczJcCBrsWQmxFusVh1vp2Vw=
X-Received: by 2002:a05:6402:3550:b0:688:3188:f4a4 with SMTP id
 4fb4d7f45d1cf-6889c4393demr13460887a12.11.1779925704589; Wed, 27 May 2026
 16:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMrLSE5izyWrP=t3_7UWjKJTd296fBrdoHZBW3DMMCzwPY9v-Q@mail.gmail.com>
 <20260526133152.1205929-1-charsyam@gmail.com>
In-Reply-To: <20260526133152.1205929-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 28 May 2026 08:48:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-yPx66ZgeH-NO6tK1svi20UO5XOjSiN9WU27b=Y+RBvg@mail.gmail.com>
X-Gm-Features: AVHnY4I4cjVbTBQEnPLDrG0rR-r_s3GGRF9NnqTcpEmYwvowiBMbwxbeDIHePd0
Message-ID: <CAKYAXd-yPx66ZgeH-NO6tK1svi20UO5XOjSiN9WU27b=Y+RBvg@mail.gmail.com>
Subject: Re: [PATCH v3] ntfs: validate resident attribute values on lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
We can make ntfs_attr_find() return -EIO instead of -ENOENT when it
detects a corrupted resident attribute value. And callers should check
errno not to add duplicated $VOLUME_NAME.

>
> Do not add $INDEX_ROOT-specific value validation in this change. Testing
> with stricter checks showed an existing ntfs_ir_truncate() shrink
> ordering bug: the resident value_length is shrunk before the root index
> allocated_size is updated, so a relookup can observe allocated_size
> beyond the now-smaller resident value and fail. Fix that ordering before
> adding the $INDEX_ROOT-specific minimum-size and structural checks.
please provide patch series including ntfs_ir_truncate bug, index root
validation, volume name, and this patch.

> +static const char *ntfs_attr_type_name(const __le32 type)
> +{
> +       switch (type) {
> +       case AT_STANDARD_INFORMATION:
> +               return "$STANDARD_INFORMATION";
> +       case AT_FILE_NAME:
> +               return "$FILE_NAME";
> +       case AT_VOLUME_NAME:
> +               return "$VOLUME_NAME";
> +       case AT_VOLUME_INFORMATION:
> +               return "$VOLUME_INFORMATION";
> +       case AT_INDEX_ROOT:
> +               return "$INDEX_ROOT";
> +       case AT_EA_INFORMATION:
> +               return "$EA_INFORMATION";
> +       default:
> +               return NULL;
> +       }
> +}
We can identify the attribute just by printing its type, without
needing to print the attribute name.
Thanks!
