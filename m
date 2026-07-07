Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411993DA5D9;
	Tue,  7 Jul 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418664; cv=none; b=ha8GmqrEaMoyOzYPRBWv+z1lLGF1OSlAGAPbsJCiR/5h5PGlQfkxEIprb9Z/8MIGy+fhv7/pKUeQ6lp034jum4UK1h9YTNEQrA6HMNJygitXRXbYitb8JLT0EphujVxOa7tmSUku3x/l6SjqGEYn6Y9coMKoF97UBc5Yp3/qHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418664; c=relaxed/simple;
	bh=PMagzmiCPMKaOFZX7o5788vQkF4JSrZpQYAOaUrCw1Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DaJ+0l3i/lWR8FoJzDhxz0DLzdOYfyuFcFzmS4qN2xXzXYK+PiitC7+Gmr0hkyLEWkKqWJukUbwYS4NXE7Bp4a2eFyNyr7z0WRudAbYJl+ByOpCqaBd9lLNq3GU4DrOpQtwUPzNy1G42/gFZf3+Pb35AMzp7zftQJ6XiKRa1FO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjqeKAzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjqeKAzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61AF1F000E9;
	Tue,  7 Jul 2026 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783418663;
	bh=OFQdohNFbeLUZg63QqP9bpyGq18hvXGFTSyRwECPrjU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jjqeKAzuCio5rMUpO/3PgPrPqNiVaOdjK5jyW25lupYU4UA8dDHpx/zWqeiijLgxr
	 sAh9fEGV6ysoiDlF2nQXg6FCEcl4h1Ljb8j8+ycn/TZILsH4ya77W98OcYk1yfTqNn
	 uKeSLt7lqANi0+VgWpL2spekMgf3h9TabazvJdpR1Da85w6mAzIYKHLJDMufDooUJ5
	 8JyDW+6HN8BZ8iYziUldOlfFcu2NFxeug98gNaL1VMwVwuVngJEP84L/O6Vr5Wa2CD
	 4fWF6OUr1KVEFdjpNOvvX3y1GglTgfSWxuwg7eqYVA4T5EU3Av1RDCC4eaWuVHlNiS
	 29UHDtSZa43xg==
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
To: Pedro Falcato <pfalcato@suse.de>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <akyyqnv9EpY7xVdC@pedro-suse.lan>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
Date: Tue, 07 Jul 2026 12:04:18 +0200
Message-Id: <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5318; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PMagzmiCPMKaOFZX7o5788vQkF4JSrZpQYAOaUrCw1Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5nFcxPePGaHkr6tXx7Hli7xXPN4WxlUiusKrcs4/5i
 9Ne/cf5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOp2sbwV+LU2ymRZ6fmvun/
 mlL3otsm536tsaDrzvcV8aEf5R3LLjEyTF7m2bI0cf5JP5+t/C+j5tR3CGy/HxCzJvBTq2V3zJd
 yXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-07 09:35:03+01:00, Pedro Falcato wrote:
> Hi,
> 
> Sorry for comenting so late...
> 
> On Sat, Jul 04, 2026 at 06:41:43PM +0200, Jori Koolstra wrote:
> 
> > Currently there is no way to race-freely create and open a directory.
> > For regular files we have open(O_CREAT) for creating a new file inode,
> > and returning a pinning fd to it. The lack of such functionality for
> > directories means that when populating a directory tree there's always
> > a race involved: the inodes first need to be created, and then opened
> > to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> > but in the time window between the creation and the opening they might
> > be replaced by something else.
> > 
> > Addressing this race without proper APIs is possible (by immediately
> > fstat()ing what was opened, to verify that it has the right inode type),
> > but difficult to get right. Hence, adding support for a new flag combo
> > O_CREAT|O_DIRECTORY to open*(2) that creates a directory (if it does not
> > exist already) and returns an O_DIRECTORY fd is very useful.
> > 
> > Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> > a regular file exists at the open path; EISDIR if a directory exists at
> > the path; and to create a regular file if no file exists at the path.
> > This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
> > the common path even earlier in FMODE_{OPENED,CREATED} case") causing
> > ENOTDIR to return in the last case while still creating the file. As
> > this change was not detected for a long time, Brauner proposed to adopt
> > the more consistent NetBSD behaviour, i.e. to return EINVAL on the the
> > O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
> > ("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
> > the EINVAL behaviour has been in the kernel for about 3 year now, no
> > rollback is expected as a result of userspace reliance on old
> > behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.
> 
> Ok so I genuinely don't see how users are supposed to use O_CREAT | O_DIRECTORY.
> Lets think about the portability here. This is undefined by POSIX (meaning you
> cannot rely on a O_CREAT | O_DIRECTORY having particular semantics). FreeBSD
> and NetBSD each have different semantics (my investigation stopped there
> ~3 years ago; I vaguely remember that macOS/Darwin does not/did not support
> O_DIRECTORY. I don't remember what's the deal with OpenBSD/Solaris/Illumos
> here).
> So, essentially you can't rely on _any_ common behavior between platforms.
> Ok. Now, you may say "it's 2026 lol who cares about BSD". So lets look at Linux:
> - Linux for most of its lifetime had "return open directory, or create
>   a regular file".
> - It later had the above, with the added caveat that it always returned
>   ENOTDIR.
> - In 2023 I then found the bug and Christian changed it to always return
>   EINVAL on that combination.
> 
> Ok. So Linux had 3 behaviors and 2 of them do not make any kind of sense. But
> that's fine, we return EINVAL now. Except that the other behaviors existed.
> 
> So, lets say this feature lands as-is. If you're writing something *for Linux*,
> you have to contend with the previous *3 behaviors* for a grand total of 4
> behaviors. Including bizarre runtime tests, lest you are running on something
> pre-6.4 (system calls can be similarly problematic, but at least there its a
> simple ENOSYS test).
> 
> If you're writing something that wants to be portable, or that intends to
> standardize on something, you have some 5 different behaviors all across
> the FOSS UNIX landscape, not considering everything else. It's also something
> that will, FWIW, probably never be included in POSIX because no one can agree
> on the semantics here.
> 
> TL;DR I don't see, given the reasons above, how users are supposed to use
> this without it being a total minefield.
> 
> If you're intent on the open() path, I would suggest that perhaps openat2()
> would be a nice alternative, although definitely not as beautiful as
> open(O_CREAT | O_DIRECTORY).
> 
> Just my 2c. And I feel horrible typing this out because you clearly spent
> a great amount of time and effort between v2 and v3 as you redid this :/

I don't think any of this is really an argument worth considering.

This is a lot of handwaving for the sake of portability and concerns
about past API mistakes. To both: so what. If an API is useful it's
useful, POSIX be damned. We're not going to be fenced in by some
standard.

90% of our interfaces blow way past POSIX already - in most subsystems.
If we'd back down ever time someone shows up with "what about POSIX"
Linux would be irrelevant.

It's been years since O_DIRECTORY | O_CREAT has been made consistent
which means all LTS kernels have consistent behavior. We often make flag
combinations work that didn't work or where inconsisent before. Nothing
here is special at all.

I appreciate the concern but even if this were to fall flat then
worst-case we'd add a new flag and we'd still make that work. But I see
no reason to not try the semantically obvious thing and make
O_DIRECTORY | O_CREAT work.

