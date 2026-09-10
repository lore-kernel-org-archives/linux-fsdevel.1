Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CD3D7D91;
	Thu, 10 Sep 2026 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026890; cv=none; b=WSZEWqK6lSDpVPfUS4Xe8Z774IKlDRDYLwwCkdNmJxje9z0DabSKqcaG2OhdTUBRI2W7r6RpMj4T8P2XYxS2RlRgD9cfcXOs4rAdW3Gzue8ZczV/aaw3IbQNDhumWqDefJetLbMdPBzb46rVLxEVZW4UuOq97kFwToe/X5jdHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026890; c=relaxed/simple;
	bh=92MeadmcJtnuno8ZJ8uDmoyfowuzz/49J9L/3j9N4P8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Vg+4Di8DxVPIO3qne5FvuBxzXDjvHIcUsUkOO2beDeUeeUMXb3WYAHpZounrNWH8O5d6s9kFS/bHKgwEYAq1Fcj+RJwnnT4VOcRNXQpRcBOpmaar240lHG3mGSYHB6/QxgRB1fM3Ks8otvmTK3Bzqko2sf2yjtLrk7Jnl7EizIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCX5Y8yL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCX5Y8yL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D59F1F000FF;
	Thu, 10 Sep 2026 07:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789026888;
	bh=81xEdGdgngRiAgblNE3PtSjjrQlaJ1FhOAUhZwtimZ4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=nCX5Y8yLwh0ipMwPawk5BN+r9u0BHptijljtYjvdVEosfFEwuSST/sH/YKZvBOcy6
	 /oryXPV/HCPC3oJfgLNksqP6x1iix3ow0vW8wQ+ZRKCjmUQWxsVuV2vbx6WV0GT3op
	 BmmWyuky5rFKIIe7DcuIxdOiMqvnYsEHKQSbZZ2fSBwyVWA11ubewJ9xOLIJ6dLNFx
	 OOM54FlBTYNP0bBdo6/bSwsi3s2i92Ih4Ik+7G8W7OUgxG4y9RiYsByLy47jTWxdNU
	 ptmnZ1QlYd4ZwVJLi8KlVTnYNE43Fx5uCcwSSqy9LAqiheqsNzkjUKgvxFQXKFS37z
	 Y+G7YjUHNGXWA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/10] net: support thread-specific pidfds for send
 and connect
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
In-Reply-To: <CAAVpQUAx2K1Nhj64oEYMfQOzsp35uPhRmRrS4hnp7nd=jvj2kA@mail.gmail.com>
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
 <CAAVpQUAx2K1Nhj64oEYMfQOzsp35uPhRmRrS4hnp7nd=jvj2kA@mail.gmail.com>
Date: Thu, 10 Sep 2026 09:54:42 +0200
Message-Id: <20260910-salzig-hegemonie-wipfel-3443601bf82c@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=brauner@kernel.org;
 h=from:subject:message-id; bh=92MeadmcJtnuno8ZJ8uDmoyfowuzz/49J9L/3j9N4P8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtSnL+aZTJpvc8ktH0zVbpdcd3mMtNfxt9dsm6P/385
 tnCb5u7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZioM3wP5LFpvrfvTddXs+e
 5+590FX7cSarSYi4/7rAKt0mMXnJ5YwM75f6tr8uWzPnj11soNdUgccBNSmvV9cwOc1IzLnA49f
 KDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-09-09 23:33 -0700, Kuniyuki Iwashima wrote:
> On Wed, Sep 9, 2026 at 3:43 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > SO_PASSPIDFD/SCM_PIDFD and SO_PEERPIDFD allow to retrieve a pidfd for
> > the thread-group leader. The coredump server using the coredump socket
> > cannot get a handle on the task that took the signal and is writing the
> > coredump easily. Workloads interested in per-thread authentification
> > have similar problems.
> >
> > Add SO_PASSPIDFD_THREAD and SO_PEERPIDFD_THREAD. We record the sending
> > and the connecting thread in addition to the thread-group leader.
> >
> > SO_PASSPIDFD_THREAD functions like SO_PASSPIDFD but instead of an
> > SCM_PIDFD message for the thread-group leader, SCM_PIDFD sends a pidfd
> > for the specific thread. SO_PASSPIDFD_THREAD is mutually exclusive with
> > SO_PASSPIDFD. The last one set takes precedence and disables the other
> > one. Both SO_PASSCRED and SO_PASSPIDFD receivers see one writer per
> > process as before.
> >
> > SO_PEERPIDFD_THREAD allows to retrieve a pidfd for the specific thread
> > that called connect(), listen(), or socketpair().
> >
> > pidfs_coredump() now also stamps the dumping thread's struct pid so a
> > pidfd for that thread reports the coredump like the pidfd of the
> > thread-group leader does.
> 
> systemd-coredump currently uses SO_PEERPIDFD, so

And dbus-broker and polkit and etc pp.

> SO_PEERPIDFD_THREAD makes sense to me, but is there
> real need/use-case to fetch each thread's pidfd per sendmsg()
> via cmsg ?

I want to be able to authenticate individual threads in a thread-group
on a per message basis in an authentication framework.

Thanks for the review!

