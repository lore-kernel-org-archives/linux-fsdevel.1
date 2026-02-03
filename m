Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46D34C9AD
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123869; cv=none; b=RZbTNJNXCpNDyxl8g0Vyuc6fnUlLhMbCo9hc0BcDHnqA8vbKZlgEdxkS1W33kZKE3NvqoHrAn+F+8AcnwjQeXNTUDmtNYO0fRW/mhVESmsZqunwnprvi/HBUZJJtb5Sj2eHehTPlPXCUZyd3tWRTmvsNh3a5435xBeVTs0umrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123869; c=relaxed/simple;
	bh=7c3R076/7gKadugDbQO/yrylAwTkOVFT0c1KFw2i49g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=togc2lnikcZBuMj1KQesNjeFzZm/wzOpIFf5d/yCZScWEPsZk9VRb4PXVDKmic8HGZlW5lelKckUquTQb/y4nEZkmWUojjTytPvyhMIXltjROFqQlUur/ivwZkiBLbIX2bvKlhQ5zJDwSHdln5gjhHHZXOBgBwF2YvkHjJFoqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTdQ8UGQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTdQ8UGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2489C2BCB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123868;
	bh=7c3R076/7gKadugDbQO/yrylAwTkOVFT0c1KFw2i49g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MTdQ8UGQ8SOjaSPZvpkUVkgKyT3kumdLNgNKPz56XD+oKRpH2E0atDvovZ7t2qJxj
	 AJ946tGadqDCs3XHl4obzyVNU6oUVJkHTqNj5/KJnL2P3wugSgiq8POsum+dlElspd
	 +wMvuzda0lTGbWT5dwwmh8MJpjBwFGyeDd1oaIFC7lAk7AJlDiTXi1jCKekrqtfo5a
	 xRCEfOEGppxLLgtpMxN0m2RQgHqsNUd/pkcUMykjtrwUjKnIR0qUwauwlJlXdY7C6H
	 m8tGO/4izfCUoDcHMjxxGM5EpZHpXvUrf9u1zx5F4GPgb78GyaKHfvRET8pS+XRFvQ
	 Cp1hquIyWyybA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so7550567a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 05:04:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJyCseMR83xfPLj4RemGcLbHoRYjxQNQT8Bh0LJKIt0rnL1ouWN0FbP72KucRpRYhEp1FayVCaALYrgMG9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyts3jouXESY5TWloeo67MfcELaBcltZYe2wzR7sXAViGv0ED5+
	0sb0jyQNX44ve6LnMB5Tkrl6m0xrCjJ0/0FQLN6NQiQHToz5lhjYYLenuyh3v9G1tgnvjQ87Gnt
	/IoucowkJkQhV/T+4k1d02AYBmgop2G4=
X-Received: by 2002:a05:6402:40ca:b0:659:405b:548a with SMTP id
 4fb4d7f45d1cf-659405b592cmr628193a12.27.1770123867269; Tue, 03 Feb 2026
 05:04:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-6-linkinjeon@kernel.org>
 <20260203055205.GC16426@lst.de>
In-Reply-To: <20260203055205.GC16426@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 22:04:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_6G5ZajRQFbgKMhwQFx1=9ripOqurfaYhc1vJfDnrc5g@mail.gmail.com>
X-Gm-Features: AZwV_QgJ2CYJrXVVyqHzFXM9phxj7mLkTM8eccFp_wXXma2kg4D1kSxJdqBqT7A
Message-ID: <CAKYAXd_6G5ZajRQFbgKMhwQFx1=9ripOqurfaYhc1vJfDnrc5g@mail.gmail.com>
Subject: Re: [PATCH v6 05/16] ntfs: update super block operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 2:52=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Tue, Feb 03, 2026 at 07:01:51AM +0900, Namjae Jeon wrote:
> > This patch updates the super block operations to support the new mount
> > API, and enable full read-write support. It refactors the mount process
> > to use fs_context, implements synchronization and shutdown operations.
> >
> > Key changes include:
> >  - Implements the new mount API by introducing context-based helpers
> >     (ntfs_init_fs_context(), ntfs_get_tree(), ntfs_reconfigure()) and
> >     migrating option parsing to fs_parser, supporting new options.
> >  - Adds ntfs_sync_fs() and ntfs_shutdown() to super_operations.
> >  - Updates ntfs_statfs() to provide statistics using atomic counters
> >     for free clusters and MFT records.
> >  - Introduces a background workqueue ntfs_wq for asynchronous free
> >     cluster calculation (ntfs_calc_free_cluster()).
> >  - Implements ntfs_write_volume_label() to allow changing the volume la=
bel.
>
> Suggested tweak to the commit message:
>
> Update the super block operations to support the new fs_context-based
> mount API, full read-write support including ->sync_fs, and file system
> shutdown support.
>
> Update ntfs_statfs() to provide statistics using atomic counters for free
> clusters and MFT records.
>
> Introduce a background workqueue for asynchronous free cluster
> calculation (XXXXX: please add a sentence here why is is useful / needed)
>
> Implement ntfs_write_volume_label() to allow changing the volume label.
Okay, I will use it.
Thanks!
>
> With that:
>
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
