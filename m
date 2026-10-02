Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7464BD35C
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951194; cv=pass; b=NEFUmDG2UvRJVCbixGW8/G9YLTsUGaNMt1ZltJ/Y4DweRUctZ8cBKsDwpKpwoOP8kax37wGyn+/MAIKkg0vshEdTZAK3vZwaRICsqNqfxKB1VuaKtDBNW9tJbhnKgWap4XVsgL+qeS8u+xuLi4yTaSdeD3NbrXUL/VLmuUW2H6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951194; c=relaxed/simple;
	bh=8omzBxIaPHs4y/ic7pol+xs+OMTn0QiqPBQq8weGQec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1xTqvQQca7N0ypXugLH9UM6yI9lcMCHonk8PS5f8DLJ5YHmKxM/yxQKw5uH8MOv2tzVGeYvgWlYELf2pNv7aTQnZNwy8SWtIwPEP0cNRW+yF/n+JtM6EMjZMEUPa7rgabwQAs7re+q9Jb5MLEPHeWfFHlzND/bQmUjg/ezJrCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZIYcbc0; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZIYcbc0"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso2872514a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 07:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951190; cv=none;
        d=google.com; s=arc-20260327;
        b=f2rbkvS9JhbJiVwJAtqsjPA+407eqBMpCzzZ/5CoVZTwq14z36rkyM0po0Jy7apftW
         /ouQosxZri4Rw6uc85/H5DY34ACTCA+6i9KFzVQs9vZ8Jh5Gzy5gMjs5ZxqOxUtR3fRK
         4nOexMwUENsNfzSbMiIzNb6jV4hTMWiYYHfDvxdWGnO9tq0nZTsCky0p6s7AZuoTSGUp
         TruBPRYX08HY/RxOWSP6uavD1+5I/0MAHGawU5APesN5/+KS36V0XP0112J7yNMY45M+
         TNJnaRLSy4hY3XACiA+ih4BXs4iXQX4C1h7nsoqQa8XT6o4bDpsYfANB84Obbev3aeSY
         ilwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8omzBxIaPHs4y/ic7pol+xs+OMTn0QiqPBQq8weGQec=;
        fh=izuu5a9Lcgf9OF6MdJzWQJyfFlLqEksdPp85uMgyjJw=;
        b=A/MPf4moqhy1emprFNVWh3zSMJthsuC+A7yXIpADJGLLiZKO2RtQUcRaiB9z++xCVY
         bZ4tl9ZTkBxZ1lKJGLxG+DbAvQbLB5+w1Ec3jVyHzk3gqc1ssuUdtJDHi10Yg6f6PnWE
         AIuLq3Fl33Y5OpNzuY40G/fYLwAhCZU78d7pv3NWzhCosH9IVeFHQIijsz4X0rS3eGDn
         xMKnFA6hW3yRczZJHUgZnk7whvnbPC0g4yU4h2+KTTJ+ZOTRZAZBWIoWM1UMzmPDllBS
         DEnP7KSNbscgNGp0f6HxZ8aMxt0uMRf+Aixphb8KU6DhT9M+snIyO6gRxafHXItD8kmX
         3Ktg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790951190; x=1791555990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8omzBxIaPHs4y/ic7pol+xs+OMTn0QiqPBQq8weGQec=;
        b=PZIYcbc0LCOKczeJweoQC2puPJbubUqaAzf58HP/a2powmiC3KlM+IWKhIAOj8L+Ts
         t4sT7yKQ5YFeDO2FeQLn5If9aBNk7FRgqPEkuWqE388lSsWRmHa+oKSfadyilAyNWxZl
         YJVcW8ypfNimDbln+Bjxa7sA5a6aXo/n3ET4fcbS3i+WeSnApv7AwxFPYaZbTSrP4lJC
         73Tc0FmqPJjd8pCylqz9VzSZhgrFU67xyu9waEgFPmrvlxv8kFO/flllv6ASR1YGwDyL
         b7+MEGN4HFVT9ZhjTzIDWR7stBklTW7TKgE+hSD1Tv1B3L6IlLxAEBoQkBTgS2AOoF9v
         YQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951190; x=1791555990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8omzBxIaPHs4y/ic7pol+xs+OMTn0QiqPBQq8weGQec=;
        b=aA//wGfve3eP01Y4mFTBNRYqkp5FfrZyZiAntQ59Zjn+qX/2kXng+ze5phw9HyktuD
         rjVPeOHMvgTh0wHI5DuHrfvj6oFS+8cQR/nzm3nss3NWhRFtEUEJmmPY1EJisD9DJ4HM
         dA8dWJ9fOPRqksrAvxux14eHc/BD88Jz09dbxN17q8j5b6YUZr0gacB2NSIohfiX/WII
         KC/4//L08I91Y3VpCq94pvNlg2IK/S1gob9ria7iSdM13p049WErlrM0gH2dw8JHxrqW
         LLehJc9WQ5TP/dcJMqr5qCP37x3m1T6MVGbChZ5TGeSMann5dHH1Q0PAET8Nkk8jB0pF
         Amcg==
X-Gm-Message-State: AFq9FYJISAwVV8uuQUA7VNaBhiZMTZ7tWs+25MsM45V1CuiyOxWS6gRg
	biDZ5VO3XSMUJO5JiJAgJA8VBiKPy6nN78JEZ421tKyz9Q49SA5XbqiWbOVK346HL+jRusJuSjU
	4q7bNEjhWaLFAmejYS0Bi7dz3WD+bKWyer8oJyGc=
X-Gm-Gg: AYBFou1H8m1qLuyvu1xO+1Ab1i4Yf9d3cMblRiptaO8kgjDvGE63HFzdBYmLvUpx5+S
	29FWo5NK7GlBjnCDWj2U0tu0n2C1B6LbP5uG5FkgOyz47fUaRw138ALzSc5fc20jnd1Bdn9kuCm
	TbUVprh9E9uRJnTw+/lWuFzPHE3cPcKlifvgmzNjlX3oz38L4auEKA4v/w31gdvtlnqJkSK6bB6
	PkvXQVqrkO6jJDFcLN43qm97hA6qUsmizY6NWkyTcNle//nZPDtckwiklue0nzjeB5olO9J4//7
	uPHnjKQ+lXUY2uXLjvm9fzTK4updYiZC4HhGdHk7lRM093TiBFaYZkkbLw==
X-Received: by 2002:a05:6402:3448:b0:6ab:18d:553e with SMTP id
 4fb4d7f45d1cf-6ae307fc2aamr3778893a12.7.1790951190378; Fri, 02 Oct 2026
 07:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org> <20261002-work-mount-fixes-4-v1-16-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-16-dd44b89d44ce@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Oct 2026 16:26:19 +0200
X-Gm-Features: AclHuK9Z16udPk3oh0sLXTcta0Bo8aFfXZ1FbZojqYzXzTAAqgvE-FwFTndyA9k
Message-ID: <CAOQ4uxh9O4-sUpN5mT-GHriGQ26R_n++mELNh3wOPKSrMYDSRQ@mail.gmail.com>
Subject: Re: [PATCH 16/21] fsnotify: let a filesystem refuse marks on its objects
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 3:54=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Don't let nullfs be watched. fanotify refuses mount and filesystem marks
> on SB_NOUSER superblocks but inode marks of inotify, fanotify and
> dnotify go through. The one inode of knullfs is the root of every
> kernel thread and the following patches make it reachable from
> userspace as the directory that stands in for an unmounted mount. A
> watch placed through one such directory would report the opens through
> all the others, across users.
>
> Add FS_DISALLOW_NOTIFY next to FS_DISALLOW_NOTIFY_PERM, refuse a mark on
> any object of such a filesystem in fsnotify_add_mark_list() where every
> backend ends up and set it for nullfs. There's nothing to watch on a
> permanently empty and immutable filesystem.
>

I don't particularly mind this custom opt-out, but
shall we perhaps instead deny marks on SB_NOUSER directories?
IIRC, we already wanted to deny marks on any SB_NOUSER, but then
it turned out that some users set inotify watches on pipes, so we stepped
back and restricted SB_NOUSER only for fs/mount marks.
I think that the same logic extends well also for directories, because
I don't think that any existing SB_NOUSER fs is supposed to be
exposing them atm, so no regressions are to be expected.

Thanks,
Amir.
