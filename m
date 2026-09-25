Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697014A4CC;
	Fri, 25 Sep 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347541; cv=none; b=Fo9y+oejkdfo7KfWg9873AsTvq4LN834Y+1FLhXWuhvP6MqvnTrg7133sogGufrYpZyORmXIMb6QRZ33LFO9TXQbp2TiEsQx3CyJZM+aO4/KIo0E7pvQrvkxjBRUqbDBgbQZAacKm5m8hDQPrPxxKxoBHaPC0Z50+MgrhkV755Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347541; c=relaxed/simple;
	bh=iwEZ3YQL5Cx9aYwS3qBotJ05FuyUpuReFsFpFdq3HTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jkoCLMFaMApo9rQe9x9hkE5GjOFSw6XAya9YzfDrB8oHBnrFkbOWMsGhU63X0ORTQMjeW57YLDrMtpnwG/OpuGTzCgBRFSxoAtiDfz1xqqAXhDOR0+cwQLqQxK6O0lf8H2cwXYm5hBIGqsAtX6wEu1Rj2d2Eo94V/cweaYZkyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deZT3orI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deZT3orI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4221F000FF;
	Fri, 25 Sep 2026 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347540;
	bh=vugrh29bBK+w0SLfqkgJ+IagU+hvz3QTBu8nknU8jxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=deZT3orIdhDMOjfpIrydDbVfGZbmWXNzoBcdtDeoHRXPeAXYB5lRA0Erhc6tYWZ7u
	 I+U6koz0TR1EPvqnxShFkbfU1smhiiuXG0CeD5C6Xrer4h5Ytv3Hjh4Ri2JdMxUeBF
	 XEgiH0i3+9+PM/1VDyAook5WzhlijzDDc4+MSfAmsYni6Ot+uIWUSF/P/au9Jfz7Ao
	 dLWEwtbGGqio9pyFDVaOP0F8HfjPh0YMGpozQv6p0uXCF/kqLzdeNCvwBqFsZH3xOm
	 EIOzI3d9VUxq0jpKmMtAILrRgBceKihHP6nb+AnKKhjDQ39yGXA1AcrqsVw9dJZBp1
	 b7CbrSwpBV++Q==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Breno Leitao <leitao@debian.org>
Cc: mjguzik@gmail.com, oleg@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <20260916-b4-splice-poll-key-v2-1-da9ff83469c3@debian.org>
References: <20260916-b4-splice-poll-key-v2-1-da9ff83469c3@debian.org>
Subject: Re: [PATCH v2] splice: pass a poll key when waking pipe readers
 and writers
Message-Id: <20260925-rinde-drehleiter-anklopfen-61fe7cfb1831@brauner>
Date: Fri, 25 Sep 2026 16:45:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iwEZ3YQL5Cx9aYwS3qBotJ05FuyUpuReFsFpFdq3HTo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt6xRY71DdmdK/kzP83Y99wVlTA6uvLvr0zq1acOUh1
 91duzgKOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiNo3hfwlrwZr9ZzZwbXhY
 dtH81EvR6HXlB/12bH/XOp337BMVpXcM/zOnvQifP0M0vHZ5iFLHDoc5konNxjvC3i5idJosbXj
 zFRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 16 Sep 2026 08:51:02 -0700, Breno Leitao wrote:
> splice: pass a poll key when waking pipe readers and writers

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] splice: pass a poll key when waking pipe readers and writers
      https://git.kernel.org/vfs/vfs/c/5045900e1bc4

