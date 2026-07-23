Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2080265629
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810967; cv=none; b=X8Bz3l6njiYhux94JASJ3LRoPuLM61FQw4Bn+UWRidP0KeVIHRSkF0b0G81PQ2G6bpQvxt6ug/WU0Qh9R3Hkv7qQCLckVtzEb1JmT6PlDvibN2c83Ovc2cJxc1dyBm6la4WWAPhLz4ZPZjqYzOkhRe7/Rr+1dYwO9Ef6XV3FR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810967; c=relaxed/simple;
	bh=3aXeI/09MbbwuicKh8AkxPk5M68U/QigbEhhmfXM3ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRqZYGzamaYVUWRed8rBo/mPXfymUfxBqMuhy659S5O2mBLYFZdnhN2+oTZQgdk9zbeiAVHbRBFHRf4n7Iggg1RS1r/mC9Z1fpvxpfM5z1QZIlmIV3rO4sCmySc6FKTrC/GAOm+VDSEct8AVZJztjS+RUNMfB6bHhKwLcJtIusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99D61F000E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 12:49:26 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39b3931e259so5258001fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 05:49:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YzZ+sOKTALAMZCw5g9svKBY3q+H19X2BY5/HU8/QEftAj0RZuZI
	9QfxF2MtnEO5B78xb1/PIjg9JkWWTi8bW8bcyK7QfJKrBELwX3DE5iFkUontlZ0dwd5+dWgIzxS
	DIUc4Y2tcso0DqbA0hDHC5h1FvT22lxieC/B8Cpjt
X-Received: by 2002:a05:6512:340a:b0:5b0:23c3:4f55 with SMTP id
 2adb3069b0e04-5b2b2f72e6dmr632356e87.53.1784810957216; Thu, 23 Jul 2026
 05:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-work-failfs-v1-0-3f69b9a9e958@kernel.org> <20260723-work-failfs-v1-4-3f69b9a9e958@kernel.org>
In-Reply-To: <20260723-work-failfs-v1-4-3f69b9a9e958@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 23 Jul 2026 05:49:06 -0700
X-Gmail-Original-Message-ID: <CALCETrVDX-PcSJoHFwymh7d=oUKotJQQuh+AzmsA7YQySBzD3w@mail.gmail.com>
X-Gm-Features: AUfX_mycl3zGDSAuIFoS_xjyu8TCMHpETj17AyVSnLTWihuec48LbNV5ao0Yb1Y
Message-ID: <CALCETrVDX-PcSJoHFwymh7d=oUKotJQQuh+AzmsA7YQySBzD3w@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] fs: support FD_FAILFS_ROOT in fchroot()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Jann Horn <jannh@google.com>, John Ericson <mail@johnericson.me>, linux-api@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:37=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Once entered, failfs is a throw-away-the-key moment. The task is
> considered chrooted so it cannot create user namespaces to regain
> CAP_SYS_CHROOT. chroot()/fchroot() back out require CAP_SYS_CHROOT.

I kind of alluded to this earlier, but I don't think we should promise
this.  In particular, I still think we should eventually allow a
non-chrooted process with no_new_privs to chroot to any valid
directory, and I think we should consider changing the definition of
current_chrooted() such that failfs-as-root would cause it to return
false.  I'm also not sure why it's useful -- if I want to throw away
the key to accessing the normal contents of my mountns without
changing my mountns, I need to chroot somewhere (like failfs) *and* I
need to somehow prevent myself from getting an fd or a magic link back
to the ordinary mountns contents.  If I somehow get such an fd,
preventing my from fchrooting to it doesn't seem to accomplish
anything, since I could traverse the fd with openat, etc just as
easily, or even fchdir to it and use relative paths.

My understanding of the exact workings of the mount tree is possibly
not good enough to specify the semantics I think are correct quite
exactly, but I think a decent approximation is that a task should be
considered to be not chrooted if its root is at the top of its mount
tree or is not in a mount tree at all.

--Andy
