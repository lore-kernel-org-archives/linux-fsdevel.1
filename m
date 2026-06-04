Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AA3BB138;
	Thu,  4 Jun 2026 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561542; cv=none; b=Yd1r4wc1T2AM0NILztzk7/YMBlsFoG9dHulMHqe92nZjePQurjTALFgjt/HvTrpF4Q8He5sfuPaYu3M9+s+tGwEVYlcV9YfV3R7Bq3QP3wWf+p5R5oxE1RTPjnTpgoTvmwHK75tN2nl9pwaeoLK0SXwrieV5CYEZJi9IEm+SJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561542; c=relaxed/simple;
	bh=vsk0JypdGnXdy3pSzOYXpAipz0uRn9ATw17BcanBkik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgK7+fBl0674HLmUrX+TqTusnvdxAr1C9RanY4IMdaIWjy5qU57pyDcPmmBiceRF51lwrKuPV0kpT0yzmGRVRs4MUVQnmn1E28C5xbSjUQrI0oNC75XDlpSzjOIUSveX2Gm1NcpebdJb/HqsRyUwZZtSRfcO3KQS6YUmoVOxg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze4FVpW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze4FVpW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1BE1F00893;
	Thu,  4 Jun 2026 08:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561541;
	bh=K91x/2ffgIjmsOmouiO3JYSrTs6huDvjsJAFOG3sVTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ze4FVpW+SOtw7I6TorU9JoB3x3K3Tcrl0527YTExzMGOw2+LlnhxXIuDBGXOuYZhv
	 mc/tzrheKOoxUTz29vB6NL402PQB7ZtRmlwQZrWkPYINxIele0hev1gviVxOATI6iv
	 2qjCwHU6WIuQTrSsa+S2d/jUaCutXvtzq55kPStlj7nGt0wywWejiG78/DVhwLuTS4
	 GEkcr/vdfqItfoGY3/yt1nL0kOANTLdw5xZ/scxn3ccqFKmxXmhZWAN1t6F7WTV2kn
	 Xd+iMpOHe/y/oqC5jI4QHRKPJxpamOfGMxK5HB1tIZfZshf/y7ikX4wqeUl7hg+++S
	 cUEuOmpzmu8zA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 0/2] eventpoll: Fix epoll_wait() report false negative
Date: Thu,  4 Jun 2026 10:25:34 +0200
Message-ID: <20260604-rentner-weltumsegelung-kaminholz-8393f9acb348@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780422137.git.namcao@linutronix.de>
References: <cover.1780422137.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=brauner@kernel.org; h=from:subject:message-id; bh=vsk0JypdGnXdy3pSzOYXpAipz0uRn9ATw17BcanBkik=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQpmjXor2Fztt39xsyv8f5UvW8qPlFpys4l/Xnfo2SC7 wXca17WUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBGjtQz/lFor92i1KthF2F7M SnnsnMW6WP+AQ6u1fR/7DUbzjFAPRoa2Y5vzms/pdmpvmnH6V/DX4NlTwxn/9IXb20up//h+4Qs /AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 02 Jun 2026 19:51:44 +0200, Nam Cao wrote:
> While staring at epoll, I noticed ep_events_available() looks wrong. I
> wrote a small program to confirm, and yes it is definitely wrong.
> 
> This series adds a reproducer to kselftest, and fix the bug.
> 
> v3: rebase onto vfs tree
> v2: Switch to seqlock solution
> 
> [...]

Applied to the vfs-7.2.eventpoll branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.eventpoll branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.eventpoll

[1/2] selftests/eventpoll: Add test for multiple waiters
      https://git.kernel.org/vfs/vfs/c/827382c088e9
[2/2] eventpoll: Fix epoll_wait() report false negative
      https://git.kernel.org/vfs/vfs/c/0c4aefe3c2d0
