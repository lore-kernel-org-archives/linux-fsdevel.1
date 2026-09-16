Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501A43F0A7;
	Wed, 16 Sep 2026 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588958; cv=none; b=LHJmeoOYJuUEJaMhGkejs8BSbRL2YOoEX1+xlRYn/Qtf14mNbdUUNpE4rTSGeXkvt+NcXH4iJjeoG/h0sWcSsNIzIak9Jb5P8rMESmTtjyIb08C7SJca05BUxiPg6EruTD3gcKsUui6OCXpJpkc0/E9k3AUnL91BiQuco4z8P7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588958; c=relaxed/simple;
	bh=4VPXVRsL/JYVebZmiRbYJ9Zfe5tiRltX0zNY+++VXEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZIlttQVM+adlVUkT/YmDgXBb+qzFSBQP70/dBs4B65oRtq6cKQwnzBjhRsB+15o2WrgIEVNdNISgfoiTGDb4kHQqx6wcUDZrtYseyK/oaONgOUoo2mK3uNJA3AB/DaRt1x/WvBrNavZU1T3CenCb6iUr9rmsxI+sM/ajzxBBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=vgXzLwGO; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="vgXzLwGO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=GhMZiNqLd2dOE9/TX3oM+jpcEYp/1e6C8q1PDfzzjkQ=; b=vgXzLwGOpQOBXXPQN2pMb/CaIr
	GlcDYeiAQJwPbmquxE+qM8BfOd5ks1JJgEos0S2/j2gDSkFaG6eXrAv8t33GrHlr8amtxGUk8BeJV
	zhZr+sYDHAWrMZ3onDsnjJHJp+QVBpOYWiCZX8EPVKsyLem+KHPGZHxrKSZqpK7PNwlw2lMupINjV
	O0KZhy8GHWsH5Mzxy/XtoHorUS21LmG0rdWuznFpxK3OfotX424G1biIidwij3jdCAKXQfBwOx04E
	O1N0RgZ4z4QQOhRvQeWlqgPhQa+H95iLJGXDyts//d2OUXVhP49NhtJhgMg/0kVpkorHOBHGV5hSC
	aUlammiDA3lczTsycz3rWx6+eyHok1DbDRxWVPEhJPB72tgyuo4CuigO579HedomojitE70NnNSsB
	paJJ++nHZDbyVw0zln9E8t76skIOhvhMF5HrSL8lYKSRkrXNWDHeojOR/DzMCEXaATKsdh3i+j6WA
	lk6IUT2voJdE/Ssaez3+FAtwF8B1bDA493pMmZ2CWRP/DpWGCVgzB3O7PEwt2YFGl4kSsq8/giV8Z
	abrSWHu2uWSykGVzbDXylXTPmq4Lxj8x6ycJX2Iha/M6Ejp2Mf0vkhEWYdMyV08d2vXqlaDRfkHd8
	oFwsiayx8QQIsrsEnpFt7u+DFKea++TobiTEh1MnU=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 v9fs@lists.linux.dev, Haobin Wu <853555@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, willy@infradead.org,
 dhowells@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject:
 Re: [PATCH v2 2/2] 9p: skip directory entries with names longer than NAME_MAX
Date: Wed, 16 Sep 2026 22:02:08 +0200
Message-ID: <3910569.MHq7AAxBmi@weasel>
In-Reply-To: <20260916135403.15789-3-853555@gmail.com>
References:
 <20260916135403.15789-1-853555@gmail.com>
 <20260916135403.15789-3-853555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 16 September 2026 15:54:03 CEST Haobin Wu wrote:
> The 9p wire format carries directory entry names of up to 65535 bytes
> and nothing on the client checks them against NAME_MAX. Since the
> previous patch, v9fs_dir_readdir_dotl() passes such names straight to
> dir_emit(), and the VFS only rejects names of PATH_MAX bytes or more in
> verify_dirent_name(), as -EIO, which again fails the whole getdents64()
> call.
> 
> A name between NAME_MAX and PATH_MAX is therefore returned to userspace
> even though every later operation on it fails with -ENAMETOOLONG, and
> POSIX requires readdir() to only return components of at most NAME_MAX
> bytes. Nothing can use such an entry, so skip it instead of returning it
> or failing the listing, reusing the strlen() result that was already
> computed for dir_emit().
> 
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
> Link:
> https://lore.kernel.org/all/vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh
> 7i3@2t4wnhfxs7qv/ Assisted-by: Claude:claude-fable-5-1
> Signed-off-by: Haobin Wu <853555@gmail.com>
> ---
>  fs/9p/vfs_dir.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index af00b79d801e..ad6fdc99883d 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -173,6 +173,7 @@ static int v9fs_dir_readdir_dotl(struct file *file,
> struct dir_context *ctx) }
> 
>  		while (rdir->head < rdir->tail) {
> +			size_t namelen;
> 
>  			err = p9dirent_read(fid->clnt, rdir->buf + rdir->head,
>  					    rdir->tail - rdir->head,
> @@ -182,10 +183,14 @@ static int v9fs_dir_readdir_dotl(struct file *file,
> struct dir_context *ctx) return -EIO;
>  			}
> 
> -			if (!dir_emit(ctx, curdirent.d_name,
> -				      strlen(curdirent.d_name),
> -				      QID2INO(&curdirent.qid),
> -				      curdirent.d_type)) {
> +			namelen = strlen(curdirent.d_name);
> +			if (namelen > NAME_MAX) {
> +				p9_debug(P9_DEBUG_VFS,
> +					 "skipping entry with %zu byte name\n",
> +					 namelen);

Fair to say why:

  "skip dentry: name length %zu > NAME_MAX"

This is only handled for 9p2000.L so far. For legacy 9p2000(.u) this should
then also be limited in v9fs_dir_readdir() IMO.

/Christian

> +			} else if (!dir_emit(ctx, curdirent.d_name, namelen,
> +					     QID2INO(&curdirent.qid),
> +					     curdirent.d_type)) {
>  				kfree(curdirent.d_name);
>  				return 0;
>  			}




