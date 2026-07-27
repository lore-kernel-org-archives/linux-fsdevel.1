Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79312CDBE;
	Mon, 27 Jul 2026 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137602; cv=none; b=FlH9wX4G36ogO0TKAFtULimOR7OkCugUVp3ytvTqT1kogKgQEKRzPo9CZ5f2t/Mg53ObtNUJPpxRofUUao3Hm0AC+JtJPVIrQczGIhidrPwyAUBmbO+cig+hOmxLwBZ19ZCrIHqCr5bMhQaXVIsxElRGf5bRew1ApWv6cJQNWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137602; c=relaxed/simple;
	bh=Lp27sdRslVuthq1n8xkJSeE1CDBQZ3AZ8NnjVapqebI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DNaawxmN1EzH245TKbVw/EK4kS9/lpViJ5y7u45/8nDxCssmOWCfhmD3IPsQIAvQSUSrxLNo1Xl6YZVFKSUVaKV3QPCbExBnK30UZZRQWes25XtZyhNB9s11W2k1yzwAL9vEAGXBJOY+yg+TJ0UX99mYYUBg4OBaZ1yjTdb9JK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IemvCb+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IemvCb+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2E21F000E9;
	Mon, 27 Jul 2026 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785137600;
	bh=lpw8svV/iUBE/i9qIbxiqPud9mEmkRC0V1Rp1g4+Xqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IemvCb+/4t3yThEi60t+3qKzDAlTfGbVOl6Nt4i5CAgfgPA5Ft3mTsMfUwqo0pe32
	 Elw5N5BNnlqitm4+UC8m3imHV3hhPieLGvPjWSP5gIe3A3aV5orqgCOh6efVgrOi2M
	 WQpnwDoLujdwEWqbkwswLrog+P9PsY0mBQYSIaEXSRaZ+NOMOVYLUWR2BNQAaREFma
	 iaYN4g34URxqnQdJgq/cBgwWIuIezYylyK3gwqsv4MHjSm7cV0E3ZUMhFNp0RcgRr8
	 cY63WGgCfOqNA4X56vMwnaYTvBU6i1NQ9epPSAkX95M8xYRYHE/APz6UpQ5NBmc5Eg
	 s747LwBxKAq9A==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, 
 Shivank Sharma <shivanksharma2376543@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260716160944.1331096-1-shivanksharma2376543@gmail.com>
References: <20260716160944.1331096-1-shivanksharma2376543@gmail.com>
Subject: Re: [PATCH] initramfs: fix typo in reserve_initrd_mem comment
Message-Id: <20260727-spontan-hausieren-achtung-22ffc00bd8e0@brauner>
Date: Mon, 27 Jul 2026 09:33:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-09492
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Lp27sdRslVuthq1n8xkJSeE1CDBQZ3AZ8NnjVapqebI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSlc+7/WBfs49C4y/ZptXMlL9cLh70dCcH775s6auu4m
 6y+ERnTUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFwfob/laWKm3o3/3KfUVSz
 S/J6DvPXEjmJXGdzmXDTdy2NDDO+MTJMervghX6+5SbhdqOqc8tcl0tLZS67dyOXX8GF89YBQz1
 WAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 16 Jul 2026 21:39:44 +0530, Shivank Sharma wrote:
> initramfs: fix typo in reserve_initrd_mem comment

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

[1/1] initramfs: fix typo in reserve_initrd_mem comment
      https://git.kernel.org/vfs/vfs/c/9125a2d58e62

