Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9A3A6418
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560123; cv=none; b=f+7gjfL3rHzdNCij4sNwKxDJeB2owXadwfGRAyxXzMSbPnTtusvzYIg8DtKQqtL1iMzE2NO9tEyFB8gOm2v4B3GUhC6SnvarUmGnhv+9edOkNYeke/EULJ16hh0p9wuRn9YNOKqiMkxzJJQn/OlD8w1zwwT5eOXZ/N8S8HHcxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560123; c=relaxed/simple;
	bh=fPabSMHlPHPkUA8KI76og40fs4F9bLkBTVzafT6UzHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tz8SdUrvAL+8NZL4J6jvbARkKXITn5B8b9YqkrkVZqYvbQDKl37S9Fn+60hICBQjDmFAwmt9xnzxUOS60W6hMEFs0lfGQaB3HWQilcR5w+OJCzljSp7bJdaEZdnqe5OwIMQr7PGav9zVaYrWH6vit6opkMSywMywbc/ZT0rPkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS2Gru0P; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS2Gru0P"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2243378a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560122; x=1788164922; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F55vLBYMb73Kabi8Hv974kZQK1o3EdqeFc5sYbiSR/Y=;
        b=VS2Gru0P81sClbb0k6LRl+HCg8FirMF8uss1BGvWHGbUWqY1VshXJkuSK+iXtZ3uff
         TN+FZvbHuWbv9um6zERobx5hO6Q672zx0x7xSr+h02H3mgRyYI5aSSw+eex3l+4bQRLk
         yuLoRWLHj2rT136vkXJlxIcC7ZZ9Bhe/BMtqdPVamZdTvfyq55lDDvlWGnKJt26HEbgD
         6WzlKqjiGCRTeyzO0vjiIduX683LAsEZ0xKy9PB42+OBo9qL1Y8fQzC9widrwZnYRnpN
         YSxXhKRzvIE+GjqiulLSjefCWhpb3aCOuRv4J5RC5VfQk7THHAb/g75XDyussNqiSL9F
         Exxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560122; x=1788164922;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F55vLBYMb73Kabi8Hv974kZQK1o3EdqeFc5sYbiSR/Y=;
        b=pFNpOZDSBr1K+v4AiQEhQjss9RnXLOVkGAQ3bNdMYyIk0nLsbsgPyU6Eqg8WSXNd1K
         bRfL1BzX/PlTNtXjBL4EHo+0zZ15eHJ4YWGmcwBMg4Z8xfhjBbwjZc3P0YgeYyE0Fm3V
         tHccSPtUkEISfuC7GjW4PVx9De0gpfKOr36MzYx9y8MzF3ukdzgHm60z7G39LW6wHKaH
         dfLAkSZgouIhSbzju4hQgfjEmfalspywfZznGC4sMBbGK0xudNiWmNdDdLvIX6cLi6cT
         GCzRjELJFmBl9YlXlhCTVopq7kouHDFW8tJGmrqgEPKE+NJLk+COPwQo6E2rwGaoKshO
         9sRA==
X-Forwarded-Encrypted: i=1; AHgh+RqnYVINWdo55sd0ANKOpLroU2fNY0Ceb6Lq8vSlA8SKNPbUDUb3seyP/yyGvoJ4zTDF2HLW76EsKms4FQ8c@vger.kernel.org
X-Gm-Message-State: AFuF++nIw/Mi7sHDmItXhejBoOO57fbWsWa0LUTm90ypVwvE7OWe2Ngb
	YMyFrRdG03kR44+ear9NZOW53Wzptu4vdaarFYfHkSbkfoNTgiuK+XVF
X-Gm-Gg: AR+sD12Q7SOD6Gskyqq3m2XR69wz5ABbM2hf/nhxRdC4iL4AoCM8C0f5HXfHYEc1Ub9
	Rk/SLjQspFWDhU2IXgGIb2o9NBXFLMU40vNSg6VPw2uFM7yXZVD4VYz8ilgys9kLnfRL1bCyZ29
	FVPjwrHR4t2dBBp3ImNIIZ6xNe0BWEYyI9gNqcpYeWO01t0ITfx8UUprvw6MVtAX43Wsn4WapNG
	zOjhwO7Jr20gWYIVq88ozZHPH5tqF/5rvyl46qUUW7kp25oKY00z6hi12NM/Kl13epEbrClVGjQ
	s2DfeYTrm45Ynp//A+ug1v+4OyKPEKB3mpztx838EOVfeyfAg0j77BM2f962EC6U+2+uErkSZ/a
	ibebG2OEefzBJ3rLBUlyJY+ldohct9v8FMLsPSav6zAgDLOH/eJt6H71nulMIHFJNuiRgzS9ksX
	1ewDyg5VT9yBkDt91Ibay3oJ/E6dsm8MFh64W/AH64+ILHjeB6xTsNR2z2R/cTLAw5SS5O4OZvp
	4D2gphxutLs6q5WfQ3p70trzUtzY+Y1x9PWPnGwCLfDGGKROFmvZw==
X-Received: by 2002:a05:6a00:8014:b0:84c:4b58:2cec with SMTP id d2e1a72fcca58-8520ba2fd59mr30678445b3a.15.1787560121817;
        Mon, 24 Aug 2026 01:28:41 -0700 (PDT)
Received: from [127.0.1.1] (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f149af7sm1662253b3a.40.2026.08.24.01.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:28:41 -0700 (PDT)
From: hanzhijian <hanzhijian1991@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Russell King <linux@armlinux.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fix s_fs_info leak when setup_bdev_super() fails
Date: Mon, 24 Aug 2026 16:28:30 +0800
Message-ID: <178756011059.3396993.4126096199529010824@hanzhijian1991>
In-Reply-To: <20260824080746.3390459-1-hanzhijian1991@gmail.com>
References: <20260822023918.2498361-1-hanzhijian1991@gmail.com>
 <20260824080746.3390459-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Al and Christian,

syzbot reported a memory leak in adfs [1], which I traced to the
interaction between sget_fc() and setup_bdev_super().  My first attempt
at a fix (this patch) turned out to be wrong and I've retracted it, so
I'd like to understand the intended way to fix this.

The leak path is:

  adfs_init_fs_context() allocates a struct adfs_sb_info and stores it
  in fc->s_fs_info (fs/adfs/super.c:443,463).

  sget_fc() transfers fc->s_fs_info to s->s_fs_info and clears
  fc->s_fs_info once set() succeeds (fs/super.c:895,905).

  get_tree_bdev_flags() then calls setup_bdev_super().  If that fails
  (the block device cannot be opened, is read-only, or is frozen),
  fill_super() never runs, s->s_root stays NULL, and the error path
  calls deactivate_locked_super() -> kill_block_super() ->
  generic_shutdown_super().  Since generic_shutdown_super() only calls
  put_super() inside its "if (s->s_root)" block, the adfs_sb_info
  allocated by init_fs_context() is never released.

My patch tried to hand s_fs_info back to the fs_context:

        fc->s_fs_info = s->s_fs_info;
        s->s_fs_info = NULL;
        deactivate_locked_super(s);

but syzbot's CI then reported general protection faults in
erofs_kill_sb(), fuse_kill_sb_blk() and xfs_kill_sb() [2], because those
filesystems dereference s->s_fs_info in their custom kill_sb() handlers.

I notice sget_fc()'s own set()-failure path does the same "hand back to
fc" (s->s_fs_info = NULL at fs/super.c:899) but pairs it with
destroy_unused_super(), which does not call kill_sb(), whereas after
sget_fc() returns the superblock is already published and must be torn
down with deactivate_locked_super().  What is the intended way to
release s->s_fs_info in this situation?

Thanks,
Han Zhijian

[1] https://syzkaller.appspot.com/bug?extid=1c70732df5fd4f0e4fbb
[2] https://ci.syzbot.org/series/1ef55243-f163-4d98-bbd1-41b579082704
