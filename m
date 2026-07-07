Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19C3F65E7;
	Tue,  7 Jul 2026 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421509; cv=none; b=XAUDO5E/lo15UGJdghxUKidLo32SvnffNbWAGpRNq8rGmNh8loFXe4XVfv8QlOlPdn+S8XTSCUNXdXjl9G6wmwTDl2w/cvJB6j3emKcp9hl37ezIkuNMPSOA/kex/5oxyN7FgY/FQkbg+jjpsxtmxYEkbxCXSIRb5A/1fciMbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421509; c=relaxed/simple;
	bh=TBIt3XXiF4vmPS31YjE/vyZjfV2vBe6HA8C4GHaC+vY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NSovDaVdq+MGxMma2VFo99K7YTI67FzIUbvwqOYDxXrRSWt/dAJEpOJoawB4I8+sDTlf4cBg5R7j75zSwZaqVSbYPME1IjXcYnUYuqfflUpSCaJr8XJVc1w84Anx0QpIFp0Cm69w0nuKVORvuU9rPbqRgg/0+cobkKJ9hByfC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1PK+hFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1PK+hFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB121F000E9;
	Tue,  7 Jul 2026 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421508;
	bh=K3DPXzQrTD9yL1q/zH73R4p44+9FZUxs0gZq4MECShM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Y1PK+hFL6648Vsxy4aSrP/+3fejI9xfu2HPfBUEVON7pSM855B4AKIsWdLoLFHfvk
	 KrLbAswPu9yBe1rt8gF+45qxcOQeT0mBfLWIYW1TUTnmwPo9AOGguofpwTlbbwSegL
	 /YkZXTb6ZxGPnlTqszuyAryjke9P7BtIYl7dHknzmUg+pesdCbRx5OuWwPt7XMrjJf
	 1WgoaLZ9EpUdws7F+s3Z+6009U1zIs6Ra94kEkQB0CncNjt5BGlTE7WiUPOqQLTNot
	 PMWBPywrS23gWu1z6Ew3LGvWEPX39eYpjjPyoxyHUHRh7Yesz/VTFUlQeLLIzXCPJs
	 bPzTS0NUbH+ZQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-10-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-zeigen-lachhaft-situiert-1fe7432e21f9@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2925; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TBIt3XXiF4vmPS31YjE/vyZjfV2vBe6HA8C4GHaC+vY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DIwyF+wXiAxeaXrmkdrk+Rr4jj7r1hPvesgYZ4gI
 rzEZEdERykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER+hTD84fAIe/F1ZUwpn/Ez
 7hdlxYYXKhY8uGZ2rq7M5frqbWta3zEyzKlIW6srFftvYUPcTOf9WXw5xoqpO97OMv35RN/4x/L
 9XAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Currently there is no way to race-freely create and open a directory.
> For regular files we have open(O_CREAT) for creating a new file inode,
> and returning a pinning fd to it. The lack of such functionality for
> directories means that when populating a directory tree there's always
> a race involved: the inodes first need to be created, and then opened
> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> but in the time window between the creation and the opening they might
> be replaced by something else.
> 
> Addressing this race without proper APIs is possible (by immediately
> fstat()ing what was opened, to verify that it has the right inode type),
> but difficult to get right. Hence, adding support for a new flag combo

Eh, but that still means someone could've raced you and actually created
that directory. When you bring in a shared filesysem state with joint
cleanup responsibilities things aren't easily solved by fstat()ing.

> O_CREAT|O_DIRECTORY to open*(2) that creates a directory (if it does not
> exist already) and returns an O_DIRECTORY fd is very useful.
> 
> Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> a regular file exists at the open path; EISDIR if a directory exists at
> the path; and to create a regular file if no file exists at the path.
> This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
> the common path even earlier in FMODE_{OPENED,CREATED} case") causing
> ENOTDIR to return in the last case while still creating the file. As
> this change was not detected for a long time, Brauner proposed to adopt
> the more consistent NetBSD behaviour, i.e. to return EINVAL on the the
> O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
> ("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
> the EINVAL behaviour has been in the kernel for about 3 year now, no
> rollback is expected as a result of userspace reliance on old
> behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.
> 
> O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> filesystems. This is implemented by stripping the O_CREAT bit. The other
> option of simply returning -EINVAL leads to inconsistent behaviour:

I think this doesn't spell out why that's done: afaict, netfses can't
currently deal with O_CREAT | O_DIRECTORY without protocol extensions.
So that means you force it into a fallback mode where it manages to open
an existing directory but fails with ENOENT otherwise. This should carry
a brief comment why you force that type of fallback.

Also, how do you deal with O_EXCL? If you strip O_CREAT but leave O_EXCL
depending on where exactly you do it, might this risk opening a
directory giving userspace the impression they exclusively created it?

-- 
Christian Brauner <brauner@kernel.org>
