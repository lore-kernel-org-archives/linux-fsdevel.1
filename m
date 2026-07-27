Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B524BBF4;
	Mon, 27 Jul 2026 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145206; cv=none; b=rHhxU8T3fqMWL1K6Tty6YUjVIM16PEWyrKZfB1nvrn88CgEAkShpgfAdXuVl+DzJGqbEfwKgDldzPY5mm2F9K5zAlpx4S0VyUN7UdBr7Psrk2YTQoCi9izpcV0YfE3UqtzSZGTTx7i1jRDhFtyLic1H+SZObq73khY69pAH1Y1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145206; c=relaxed/simple;
	bh=yLR30xNyj9Hv7o8iF05JuEgF0Gm1WRh7tVbCDwaZYHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YrSkOdGFi+TinMDTpriqTDpkJcsSXTX+SYf4t9rxCAwdDgxEyXc1oqw+fuo9Jwh2cCdVK/pCKc76d9789YPbF6iNPxfA4n5Z4XOuJb88zUO3EnGOES7XbiNV+56hFrbyg7Ws0e9znozzYMMP13qIzR3jvzS71WMCLm5mVZ7C7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNmY5K4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNmY5K4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6F31F000E9;
	Mon, 27 Jul 2026 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785145205;
	bh=nG12GJ94xzHWxWBMtZWxcNxF3f5tGCSvJArKXucHFi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JNmY5K4YDAGEKeYFBRIXvu1fPTAb9TbXLsDzp8N906OEfAXjXZv77zlL+L95sJclw
	 QEiU2In08FaPZqOFUBmh+UH3zLjpETR5Lszz77SDFrvGoVDPDbiX0stRvyA6+o84D1
	 b9KN01cFrMIcItfYZxeh2rAOShFi2oszB2NyHAkp8u2rAmophahbmxGAU4p2A8Ibdw
	 gD+lY0KkVBZqj5vMVs8KaWwgRKvgVs+Jku3dieGydFV7QvPz9cgAl7IAj3q5cwoJXm
	 orIFXwffyRH5SqmRVskx1h6y2q/hJVNbxZknuP2GnLsY54x/7+qkuxgu1QcT5hnv/h
	 7JL5nhWZzQOFg==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260724031021.814599-1-rdunlap@infradead.org>
References: <20260724031021.814599-1-rdunlap@infradead.org>
Subject: Re: [PATCH] nstree: add/fix struct ns_id_req kernel-doc member
 fields
Message-Id: <20260727-vakant-faxnummer-spaten-9fd08c8e94bf@brauner>
Date: Mon, 27 Jul 2026 11:39:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-09492
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yLR30xNyj9Hv7o8iF05JuEgF0Gm1WRh7tVbCDwaZYHs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSlqxfPvXZiXqb5haOFy14sN/dMTbWYwnS9YHGJ9fqpU
 dNfz1ui3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRvZcY/tlazP/0Puy/xbSr
 K/7d49336cjP5g1na5fGr3wTmDA//FQhwx+e7s0yBvU2PoeLQmeVVgupzD2+cdpG5ekWp188Vn3
 NX8kCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 23 Jul 2026 20:10:21 -0700, Randy Dunlap wrote:
> nstree: add/fix struct ns_id_req kernel-doc member fields

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

[1/1] nstree: add/fix struct ns_id_req kernel-doc member fields
      https://git.kernel.org/vfs/vfs/c/ce639e4c9f8c

