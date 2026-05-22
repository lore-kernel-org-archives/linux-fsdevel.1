Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3A21773D;
	Fri, 22 May 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454398; cv=none; b=IzdiSStIp4bAEF6hW7WSZ7Vm7u4UDN0M9P5JsmixJPRAPfKo8OpJFPHc0CW+d65chduvLeO4IBp6qx+fpatnd/pjpMmp/CsirUY6K8EVaijguFxwoH2igAV+ItvBlAl//ogGlpsCqZfm+JikHvLI4dm+roKSzcxrMY7wjidx2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454398; c=relaxed/simple;
	bh=t6+ia7k9c9WkmLYEEfu7J/wmjxONdxFxed9+cb2o0DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeqTnNoFME9t8wuBWbOhkR1E0tzWzr25xNgaExNWsSqtV3I7tYqnI4v4xqC9PBjUJAjhDn7kXhlr2VDYr4ELHoVFqMTTXgt+yDmWpFuS1Q7S69APhTmnOFMknuVWPu5oxqSdq4c+YMRmCneP1weHcXgl8Rhn969W6aGU/WUbPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQIpeIOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQIpeIOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BF71F000E9;
	Fri, 22 May 2026 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454397;
	bh=G9FeCsqmdkwstxaBuf5gSmnEHDatw8qZ0J677aOVnR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQIpeIOk2sHA5CUHBH1m7yLD9T+nFpJQ0l1224kVCoGSMoHhYZYgJSEAUxaz79aGK
	 zteOMnZeS+hXAeC3FON/7zeVsFKwe2YsOXRhBBt78Q/JFbOCbY4IX1UaSK1VJBrm9W
	 r1urRFn1HVP2+WHyQULwDLzb59lnthp7b7r5F9iOnPe68ROX7qw6B9roulbEJ7Jx6F
	 /KYkCxx6F5RZQryiMv8vWUlO6fCmmLBRJZEODVeST4CxOcwfX8YErv/hvZaGsh6hWR
	 5A8XGhn+vmvVwyFoS/4gCzByb1b9U9AQh+Sefe2oZ3TCcK0QPO2vs3f++loLjYb+gR
	 jKHejMNZHnZtg==
From: Christian Brauner <brauner@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	djwong@kernel.org,
	hch@lst.de,
	Namjae Jeon <linkinjeon@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	chizhiling@163.com,
	linux-kernel@vger.kernel.org,
	charsyam@gmail.com
Subject: Re: (subset) [PATCH v4 00/11] exfat: convert to iomap
Date: Fri, 22 May 2026 14:53:06 +0200
Message-ID: <20260522-feigling-laufarbeit-lenkung-263921650bbd@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518114705.9601-1-linkinjeon@kernel.org>
References: <20260518114705.9601-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; i=brauner@kernel.org; h=from:subject:message-id; bh=t6+ia7k9c9WkmLYEEfu7J/wmjxONdxFxed9+cb2o0DY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJBG6fzH7XLb20MsDpcq2h36fDmyQM3ioodIXssr//t vl67CS2jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMCGRkmB7Bwt5dVJgldPNW 3CwN7qqzRx4XXK5eeuPvik8bzV79MWH4zb6g6kVKZ/beI+2ak+fofOzZktZyqvb7BG7Fklf2s+p 1mQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 18 May 2026 20:46:54 +0900, Namjae Jeon wrote:
> This patch series converts the exfat filesystem to the iomap framework for
> buffered I/O, direct I/O, and llseek (SEEK_HOLE/SEEK_DATA) support.
> 
> iozone benchmark results (4KB cluster size, -s1g -r64k, 1GB file, 64KB record size)
> 
>                        1 thread                  4 threads
>                      Write      Read           Write      Read
>                      (MB/s)    (MB/s)         (MB/s)    (MB/s)
> -----------------------------------------------------------------
> exfat + iomap patch   332.7     418.1           78.6      82.4
> Current exfat         278.4     415.1           42.1      38.0
> -----------------------------------------------------------------
> Improvement           +19.5%    +0.7%          +86.7%   +117.4%
> 
> [...]

Applied to the vfs-7.2.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.iomap

[01/11] iomap: introduce IOMAP_F_ZERO_TAIL flag
        https://git.kernel.org/vfs/vfs/c/f356603d90eb
