Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34A38D401;
	Fri, 12 Jun 2026 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267221; cv=none; b=L4AxJJnUkZ+Ux2LoLkfdTz1Lu/bb8UphmTs0eiA7hNJGdQMxF2z0M6u1mXZmMYuedTbqE/4F5BUL7c3nKsA6cFJYdxIeq10vy6MbZn+nPByV7FRSo2A0JHqdTP37jUgJronKilhpNCaIjdCfDc+YGQY6fJUtvE0sK64EQ5N0etY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267221; c=relaxed/simple;
	bh=aRC3JJXESXZKeSSBw7RplMp1BkyIkFyuJDOxYsM8XvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ot7HmPswFj4jlq6rEThtr9RstcROXBtrPqDXqW2zS/9NmRLyWisQisRUWnx6/MgOU6gqt20WBf+OPtLfI1q+XkJrcLNoPlK2CQCYJk5oG22udpAcRGdZVVvWVfaaPWR6IHTMhhIzX5zDaWjWThq/jpgg9xr4YW5psdLQLlfpESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzCPYYBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzCPYYBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A111F000E9;
	Fri, 12 Jun 2026 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781267220;
	bh=OM7iP170cSRyHK7jAhCzzj1Cm0vV8KdLCpu9RATcPRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzCPYYBl1bSIkRJm/HUTLaol9KwmmNZKpR9tnwP/cDD3T5i/tT7Zyomz262Ui+dMW
	 KGPl0Vu8NjoVIHYzC1mopFLNd4cb0LctqgbaQRwiHZI3jkfy9edDHJ8lc99dNJas3W
	 tXW5C29ES0hbTaKshDZqHk9gHX1nvR08ApA8SjAXQ2BmQyvmj+fKeO+JYTaERdzfIS
	 4sMQ8aPGTzAo+hdP/KNln/bkKSSQoS4yzuMYx1WfccmrA2q6oaKYzKhJtvHRhh6iZw
	 yUEpXc9UticbOmds2/Yf18ON7bESdYVgZXZxUaDYMb5MyUqAgJL5j2Fz+PXBKbobi6
	 sglvIGGqAhKOw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	adobriyan@gmail.com,
	cuiyunhui@bytedance.com
Subject: Re: [PATCH] fs: fix ups and tidy ups to /proc/filesystems caching
Date: Fri, 12 Jun 2026 14:26:53 +0200
Message-ID: <20260612-abgleichen-mickrig-couch-7bd1b5a1e634@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610143954.34185-1-mjguzik@gmail.com>
References: <20260610143954.34185-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=brauner@kernel.org; h=from:subject:message-id; bh=aRC3JJXESXZKeSSBw7RplMp1BkyIkFyuJDOxYsM8XvM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRp/+br3nX6evWBd2z+tnZzGgw7Z3w+Vnbo/rkfUy/3y 7tXsUzN7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIBhWG/4kf3A1vLHNwdZP6 27TBo+ux18P1U4OkcnhexspODXhfsZDhn0GpMuc7V+Ydc7IYDjeGy6hJFDt869/52Nbjxb4r6Tf 38AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 10 Jun 2026 16:39:54 +0200, Mateusz Guzik wrote:
> - add missing unlocks in some corner cases
> - whitespace touch ups
> - s/smp_store_release/rcu_assign_pointer/ [nop, the macro expands to the same thing]
> - mark file_systems_string as __read_mostly

Applied to the vfs-7.2.procfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.procfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.procfs

[1/1] fs: fix ups and tidy ups to /proc/filesystems caching
      https://git.kernel.org/vfs/vfs/c/cf30ceccfaec
