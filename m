Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223B3644D1;
	Wed, 22 Jul 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730944; cv=none; b=DAUZq5oZNwh4eUA4hZYJkoBh21zmTMqFnUqdTOyVNQfVqOgJPnasyLiWZYah5LloXhY79o79RBcgiS8OTiLKBGyz5TKb1y3lR5akAcjRs2d+wtHm2FfV/2RkpEaAbpy4ZoUg5bDzZMJwFJmc2K0SnK494EV8tS/vmhUBic1BKwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730944; c=relaxed/simple;
	bh=uO6QIn3x8IkrYpKtUipCivXy5Jr1HfgAY2Ra0th9DNE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CUYm2pTCJEDt9a1Tl9r0J0l5MNtdWXVFkdITOZk9sITt0mXbc0XEo5egMfnHHk82iYViES5EjIrU2C7imH8mPLJ5pISMd56NpStcln2CBKMhRdXli/T6WAf45CLEo1Bq0GLbmTIeM++0dWsjHb5+OnqNEzi5Ig56m/UxCh+KORs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Peq1ylQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Peq1ylQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C821A1F00A3D;
	Wed, 22 Jul 2026 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730942;
	bh=SJyAKEd/A5IrpcvbyRhGh6YcXq15L+Ap1c/+YzcOTO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Peq1ylQTd/CT7wMxmk0bgkYDxrIz66AFQsvFby3K4cWISoM+CM8CTReceV6LscPgF
	 loTNTW4ubP1e+PMUIqlLJby+tIBcdYZFd8qGgzwi/9caXOQ9/2ljhvyK6qvybcnQbb
	 xUTZOWaYAZypyqLqjeMlV124yQvXKyMKoDkmeZsP2uF/HTtkIm3aGVHQYfj/CMxgvt
	 VryJCodWTTvNgdZ4+TSpXOr1AfVzxCWRjHlY9H9bhi8DT6FAFdAVvv10fl7t5IznX/
	 cx5yA+52clOapjaR1VkBlw+RFCZj6yUWENxZ0ixkVT4pTYf70deYZVzZR5qM3G5eOC
	 8HfURjYVPwn5w==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Yu Peng <pengyu@kylinos.cn>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+8b3bd9f8a06658479d4a@syzkaller.appspotmail.com
In-Reply-To: <20260708080232.2564807-1-pengyu@kylinos.cn>
References: <20260708080232.2564807-1-pengyu@kylinos.cn>
Subject: Re: [PATCH] fs: annotate inode timestamp accessors
Message-Id: <20260722-ganoven-sandkasten-arithmetik-011f618b7c13@brauner>
Date: Wed, 22 Jul 2026 16:35:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uO6QIn3x8IkrYpKtUipCivXy5Jr1HfgAY2Ra0th9DNE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlXLVZWb2tQZU3VL/r+q5pibNO/Jx5ffGzpKzNiqIyj
 YFP2tt1O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyazPDf4/jJ/fL9AX2Bl/i
 3PDhkO9ujuKV9079SFBVejDbY3GQkhbD/6rFjekTvvz79znG8j6HxwyLyT08Gl+uK760nxLdWb+
 ulRMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 08 Jul 2026 16:02:32 +0800, Yu Peng wrote:
> fs: annotate inode timestamp accessors

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] fs: annotate inode timestamp accessors
      https://git.kernel.org/vfs/vfs/c/3bd226eeef39

