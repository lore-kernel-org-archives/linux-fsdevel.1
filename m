Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569822BE033;
	Sun, 12 Jul 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860001; cv=none; b=YmFcAnZUFvxquyuDOT94QEqFsQ+WEbLUVN+6ixz8iD6WBZpyal3nWfGsKzpjs/+9SujFijmctGBThoNuBgYZiZX1YnwY11mI2nBhCLZe5oWdREs/PZKOA/9JycNhU7022QzMcZVhmjpflmwXUHzKrmqfUuFtC59BHPqUzS0dtIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860001; c=relaxed/simple;
	bh=qvX0iACeTTAt8Z46NrQSivP9yjk5wocva0iY4IGLa88=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rY5Lc5Ic/7r8udgILGBWt2j+pECyWlu7KAjIspSn+Bu/u75glrSlMXAw5G7v12jMMXSb6hNBsR1RYLMcOw3ixJ9mNLZcrFY4XqBlbbaCY1Xe6aRO/hBeFdW9DCx83P8UWC2twRttIgUq7Qf4EVJDo8JpS9UsCcb/d6h7agWiBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0zOVNmw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0zOVNmw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68D81F000E9;
	Sun, 12 Jul 2026 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783860000;
	bh=0yfd+YNT57TPke1lhLYOAiircIJAPpuRD6sVwzxy9V8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=M0zOVNmwBaqDx4YKE5pVLkHjWrYoPTbiXeziRvuOykHyf4dNLCwF3ix9scDrNX7KU
	 AAkUfBCJNvRtuEgVnXP3WcZ6zEZOCXcVRknXiI7//2kBRM1jC839DGJcafasWda27g
	 +202WxAk2BM39H/Hlfg5vm9gMPMcMkFOKBn5quc9BCs0BXW/4sWZ+jznIXd4e4OMQ5
	 AVjveT2SkSNv5Ypo5ss/5tSbkG4pA++CtAFUzKHuUYNigXWPFXPfUYC+cyH82q2DH2
	 /u3ATVnZiPu3Gf82yeZ0LAmlLryjEt1NblJDK9gitH/VlXsHT15WLSQ69c0LojgTW0
	 F/1vmtwfvQLFQ==
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
Cc: Christian Brauner <brauner@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1944666535.644663.1783709759572@kpc.webmail.kpnmail.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <20260707-zeigen-lachhaft-situiert-1fe7432e21f9@brauner>
 <1944666535.644663.1783709759572@kpc.webmail.kpnmail.nl>
Date: Sun, 12 Jul 2026 14:39:53 +0200
Message-Id: <20260712-pantoffeln-erbgut-aufnahmen-8f4c2f8d2124@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qvX0iACeTTAt8Z46NrQSivP9yjk5wocva0iY4IGLa88=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFd0s/fSq1h3+fVv0qA1tD0937+f6/fhF/2zP5fjZP8
 61U4Tq3jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkYpDAyrFyV2j/vDkcGc02E
 1YJHjtv2+Es6XbJYbHr5RlV5aNhJOYZ/WpeOH1PTazjDeFNkltZcyS171eP+WMk8Dprku+2AevM
 /dgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-10 20:55 +0200, Jori Koolstra wrote:
> 
> > Op 07-07-2026 12:51 CEST schreef Christian Brauner <brauner@kernel.org>:
> > 
> >  
> > > Currently there is no way to race-freely create and open a directory.
> > > For regular files we have open(O_CREAT) for creating a new file inode,
> > > and returning a pinning fd to it. The lack of such functionality for
> > > directories means that when populating a directory tree there's always
> > > a race involved: the inodes first need to be created, and then opened
> > > to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> > > but in the time window between the creation and the opening they might
> > > be replaced by something else.
> > > 
> > > Addressing this race without proper APIs is possible (by immediately
> > > fstat()ing what was opened, to verify that it has the right inode type),
> > > but difficult to get right. Hence, adding support for a new flag combo
> > 
> > Eh, but that still means someone could've raced you and actually created
> > that directory. When you bring in a shared filesysem state with joint
> > cleanup responsibilities things aren't easily solved by fstat()ing.
> > 
> 
> Right, but can't I check with fstat() if the object satisfies all properties
> I need, like owner, group, inode, type, etc.?
> 
> If it does, then why care how it was created?

Because you might not want to delete something that another task with
the same credentials created. There's always going to be some race with
splitting it into two operations that matters in subtle ways.

> > > O_CREAT|O_DIRECTORY to open*(2) that creates a directory (if it does not
> > > exist already) and returns an O_DIRECTORY fd is very useful.
> > > 
> > > Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> > > a regular file exists at the open path; EISDIR if a directory exists at
> > > the path; and to create a regular file if no file exists at the path.
> > > This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
> > > the common path even earlier in FMODE_{OPENED,CREATED} case") causing
> > > ENOTDIR to return in the last case while still creating the file. As
> > > this change was not detected for a long time, Brauner proposed to adopt
> > > the more consistent NetBSD behaviour, i.e. to return EINVAL on the the
> > > O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
> > > ("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
> > > the EINVAL behaviour has been in the kernel for about 3 year now, no
> > > rollback is expected as a result of userspace reliance on old
> > > behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.
> > > 
> > > O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> > > filesystems. This is implemented by stripping the O_CREAT bit. The other
> > > option of simply returning -EINVAL leads to inconsistent behaviour:
> > 
> > I think this doesn't spell out why that's done: afaict, netfses can't
> > currently deal with O_CREAT | O_DIRECTORY without protocol extensions.
> > So that means you force it into a fallback mode where it manages to open
> > an existing directory but fails with ENOENT otherwise. This should carry
> > a brief comment why you force that type of fallback.
> > 
> > Also, how do you deal with O_EXCL? If you strip O_CREAT but leave O_EXCL
> > depending on where exactly you do it, might this risk opening a
> > directory giving userspace the impression they exclusively created it?
> > 
> 
> I think we're fine, in do_open() we still have:
> 
> 	if (open_flag & O_CREAT) {
> 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
> 			return -EEXIST;
> 
> and I am stripping the local variable O_CREAT bit only. Also, do_open() is
> only reached if we didn't have an -ENOENT return (lookup succeeded).
> 
> So it's either -ENOENT if the dir does not exist or if it does -EEXIST
> (with O_EXCL set).
> 
> Agree?

Sounds good. Make sure that there are O_EXCL tests, please.

