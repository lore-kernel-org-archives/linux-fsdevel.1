Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E63168EB;
	Sat,  6 Jun 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780782425; cv=none; b=UuyaoMzxB6BA3Vm7/itl8wnfivcZNaZZ1/GZqsuWjN1Yjlfv6npDivpOD5dEG0fUbJmmTp90/RciI5DAB7G54XVPHU9FgZy1UUmFfWVveOX6tHglWR3DuxXxF0+CASGnGsfET/3DXBkhSzNjNtkhYQzKAITjjYGqpKLHUsYZ2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780782425; c=relaxed/simple;
	bh=NMejAAIejA4Ak0Vi9AZ2hB0J5L26/lCSITvL+JTjgqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQJPvooR6yKy7N83FBsMh+QzPuW9bNnXszJUKqWVhY+/0tx+HWOtku9hcRp6TmW3nqGDL7LDrwsSXuDGDfvF++ZI0Vsubh4pIbCfH9vu0NkBLuv305qQ9CoWWUwAKUus13Qrlje3RSDa6/uRlKzC/QSWKMKONre081oN92Lrq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdnZY9OT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdnZY9OT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 095E11F00893;
	Sat,  6 Jun 2026 21:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780782424;
	bh=tp5xNNdtztCB9z5Adq/VV3niNebZw3nF5B3tkG+AVrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cdnZY9OTgpxz9CKPkaiYO0Rmnl27ydSk+1Lsicc+pjzixlfi7KH8xRiv88P2iDNgu
	 HrY81HvaGugD/v6wrk6fekwzwdgahpA40vX7bKqdVIhT6UTNog7dQFjKdpmZAHXMhC
	 lwNHdk9cToX5wIR/PNbrOrT0LA/y0hJpg+nTwBICIxnuygvXZ7Y0SvYaayK74crrjJ
	 hJBzecQMhn9Nb5177xVoEFe2FAqKbxTUvUM/jaR2DIl6/tpGsLFM9O1GVQbzxloGKz
	 GurW/hBnQSZY3sTMpLIjHtZKhjoZAwAC2/6UZvpHftVsNEg1eKMAIDY6iV748RHE/W
	 ZRraNsYMLm0fA==
Date: Sat, 6 Jun 2026 14:47:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: Re: [PATCH] hfs: return -EIO instead of BUG() in hfs_write_inode()
Message-ID: <20260606214703.GB6060@frogsfrogsfrogs>
References: <20260606155831.506074-1-davemadmaxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606155831.506074-1-davemadmaxxx@gmail.com>

On Sat, Jun 06, 2026 at 03:58:31PM +0000, David Maximiliano Hermitte wrote:
> hfs: return -EIO instead of BUG() in hfs_write_inode()
> 
> A corrupted or otherwise malformed HFS filesystem image can reach the
> default case in hfs_write_inode(). The current code calls BUG() there,
> which turns an on-disk filesystem condition into a kernel crash.
> 
> Return -EIO instead. The function already has an error-return path at
> that location, so this preserves the existing failure semantics while
> avoiding a reachable kernel BUG.
> 
> The issue is reproducible with the public syzbot C reproducer linked
> below. Before this change, the reproducer triggers a kernel BUG at
> fs/hfs/inode.c with RIP in hfs_write_inode(). After this change, the
> same reproducer no longer triggers kernel BUG, hfs_write_inode, KASAN,
> Oops, Call Trace, or RIP evidence in the validation window.
> 
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
> Tested-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
> Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
> ---
>  fs/hfs/inode.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 89b33a9d46d5..4192f660b64f 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -471,7 +471,6 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
>  			return 0;
>  		default:
> -			BUG();
>  			return -EIO;

If it's a metadata corruption, shouldn't you return EFSCORRUPTED like
the other major filesystems?

--D

>  		}
>  	}
> 
