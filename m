Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64153AF66E;
	Mon, 31 Aug 2026 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161797; cv=none; b=Ch/UOEfI/gwcOlTqmbwrxE10kuyInfvh7xuyG22O5bjba9PQYZV7Oalf68EfvrNLQXqB6QVez2oIkKdis1eI/+WM0jKtnob48WtMtWabKaiHuNw58Gmo0DO3bJ6YdZxatYm1XbJcfm4IpMCx1cJZIKpwfVr5kWP5M6inMwemnJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161797; c=relaxed/simple;
	bh=ElbhF3tyJA/Enm0JNhga0W5TLXrr9ilFgoBos/Jslc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SHrj42g9eJVqKjmT+8klU//pPMMMKUlSRn5CxNS4MVgjjTOOlQFWXSw2OYzKxbeF++64JAwNqNyL2PwtxfHpTqaAbqOLBoKAo9NVN17qLN9F3kj2ckhCAwn7Hzn15LOsAyjE9bh7E4aZ/8x3LdwglCGK+TszlpxpS275olQGIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEkb69+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEkb69+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F001F000E9;
	Mon, 31 Aug 2026 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161796;
	bh=vZDPoYaB8Oy7udBGcU3iIcudfXYybo8D1KGNiQgyBRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HEkb69+kgI52+rZUeaQkwkAGVOZb4ndF0Hge8dUGGj6BIAAEqKGnNQnkxYtBud3X2
	 k09H0oVKqSm2nwSI4QFX/L4iXUsIX0mJnWThwjBchRWhakW+pQgQ0rxJKLvpWz9YPf
	 RDMXZRvoCwvOlIA1mNPHuJ3gWSjgcdfd+APwKleBA2WuIQt3BBnj9CN6C8mqnGJSBJ
	 FiP4J2PTYH856T0mggpdxvswRhnd/AACuZd6PHAEyRlwbGu+/JPtJsV8kBfG2elu6n
	 K+Aevmh1aWpwaEgqwACZrv7IoeBN5OM+oVgS53NsDlVzujgU/Jc2o9mihLJFPQgtPn
	 QOSB4/Zfk/uMg==
From: Christian Brauner <brauner@kernel.org>
To: akpm@linux-foundation.org, Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, 
 syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
In-Reply-To: <20251215031433.182205-2-eraykrdg1@gmail.com>
References: <20251215031433.182205-2-eraykrdg1@gmail.com>
Subject: Re: [PATCH v3] adfs: fix memory leak in sb->s_fs_info
Message-Id: <20260831-entmachten-erfanden-sausen-b80dd3f2e2d3@brauner>
Date: Mon, 31 Aug 2026 09:36:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ElbhF3tyJA/Enm0JNhga0W5TLXrr9ilFgoBos/Jslc0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRN1Wfy+fHySXaNUm51w1IlSW2L+b2hPtmsjEuyHK9FK
 R6/L/qxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIVtxgZZj+aYR2hUbhseUaT
 gfpdpgArqXVB71hqz35g3TqtzCc5jZHh7obrR5uesPsINi/yZ7oj/KZ655zsgBLhmN7as/2Or4U
 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 15 Dec 2025 06:14:34 +0300, Ahmet Eray Karadag wrote:
> adfs: fix memory leak in sb->s_fs_info

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] adfs: fix memory leak in sb->s_fs_info
      https://git.kernel.org/vfs/vfs/c/b12e20c6ac15

