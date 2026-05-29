Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0043290DB
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039964; cv=none; b=e8PIajNhuBrC4HrDcuFh5PA2bw0ITwlGzFk73nUw0uBq/BFAhV4bZCCrV6OBKTrAuSI3aNCDx3CXY2jihQssoNqxD1WZ5QLmoO4TQNmRtJVdbV26Q/L8ErkIp7UZ2eOTdoGNdWagjjjwUk0piN7atXSKX1q4KhZFn9oDAL8wl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039964; c=relaxed/simple;
	bh=ImmIslmvbAxvKSCtlz0v2zDMtPE59Yk7v236xaMX+aE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e8BbeXj0qwzVa53vGJHGpje7Y6qP9Yr5AoJKnbKAP71M9yjCBh45PBK/YDaNFaCCYfJaMZBzjZEJg0ZHMzjllqd6LODVgbR+lHDhK6dWgbGXsk7vmO1khqQWq1FWUvUVNU+J+m9mVjudypWdiGf8auJt9YZN4WpSfyHhqpZ5ym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXkKq8xm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXkKq8xm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380001F00893;
	Fri, 29 May 2026 07:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780039963;
	bh=qR+ugTVjtRw2CkuwJ7evBgnEn+fxCDKj7EJ/zhWtADA=;
	h=Date:From:To:Cc:Subject;
	b=SXkKq8xmkvWTENlZeeNqtW8xXxW8Mwo53N+bS6jmS84eRYRORpfcPcMNbycESHQWU
	 xZ0RR99EA15C1zgxrLAwu0kzzJP9MFQf/au3YERppHSFB7EjkrswV6GiAjW71Mym09
	 JkbTi+M0nt+Wh1D9ERxw872HIxUD2jOfbmiBC1ehSxZ8DAwK5D/82aCtMeVLpp2ty+
	 5jx1FO1gC7Kf2Hd8hNvKosFbSoQz/1lN/UVjh1XwAMkoYgHjt43xEiUCgCCuAP0Zs8
	 tyRJq8VsBwbu1DUu9b2sJW95GKq1Ha4sFqmf56dsaSvwNYFvptWdu2YQELQkIGPu2e
	 svzFekeHmLB8Q==
Date: Fri, 29 May 2026 09:32:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: Moving quota and ustat() to holder ops
Message-ID: <fkr53hbpfdqvwkyrywcixxwgk5egbdb2jzgktraomq6gxpn476@a337awzsoroj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey!

I'm working on a series that modernizes and cleans up various pieces in
the super code. As part of that I want to finally remove
user_get_super(). It's the one remaining instance that walks the list of
super blocks to find a specific superblock by device and that really
only works for the main device. I want that function gone.

We have all the tools to make that work nicely. Instead of perusing the
list of devices we can just use:

lookup_bdev(&dev);
bdev_file_open_by_dev(dev, BLK_OPEN_READ, NULL, NULL);
mutex_lock(&bdev->bd_holder_lock);
if (bdev->bd_holder)
	sb = bdev_super_lock(bdev, excl)

// do the quota stuff or the stat stuff

Both vfs_ustat() and quotactl() go from device to filesystem and so they
are a perfect fit for the holder api. Then we can delete
user_get_super() and it also makes the api work a lot more
ergonomically.

For that to work I need to add additional information to struct
blk_holder_ops. Various options come to mind:

(1) two new methods (stat(), quota())
(2) a flag indicating that this block device is held by a filesystem/superblock
(3) matching on bdev->bd_holder_ops == &fs_holder_ops
(4) a single new method that returns the super_block with a passive reference count

All kinda work. (3) is the easiest one but if we have filesystems that
want custom holder operations it breaks and invalidates (3). So I kinda
don't want to do that.

Thoughts?

Thanks!
Christian

