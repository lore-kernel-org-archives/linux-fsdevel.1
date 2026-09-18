Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691113F20EC;
	Fri, 18 Sep 2026 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733291; cv=none; b=XkP7A2DEEq/E5aqv2hea7B+/IrUKyn+KnYCEBvCqvX2QVLmx93iYQxfG0/UFtmx90JNmdv1bf2pNCsm+YutaPQXB0pYwl8QbFXBrxeRLdrh+wRK3e/xacw4Otf01zg7KsRAwPWJNLLJ/OfHamoVJ3y4bNBJncpXNLsL0a3plwiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733291; c=relaxed/simple;
	bh=CBNdfcanxD/+KYaITnKl3ebz92hnYqbaEBluH3NlCfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/HEA75zwEas5XL0iznS8Gt8SYZ6lG9CnZyzSbKB6V308MBvOk0WHhaLzhz5ZLeoVaWZnk3GazfK1lp3GweqLjbiZTjLA9BfoQbTM0s6MyWUvbiXi3UPRyEaNyeYPbeu/YCv+0xhcjGaCYGxMmZ8X/lLOFNSc/f9qfOI74KEikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=hMPM5cBH; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="hMPM5cBH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=quA5j3Pb23IBKCt15zgzAbZkRT7gO4hK1CKPt5Jekk0=; b=hMPM5cBH4h9g9jRrfZfIu7gMub
	7zhloY0R1IFkA7E3qnQDj/bPPhbac+S5ckq0qdcIPxU1BR7QQlqQBiJODjhyMvCF/qxNZUpAHiJdK
	JtCviHD9YIL497CgKqfvB2WS8DTuqAK+d9fNH0CII3mjSv9brSPbhjbNDPhN8cISS5sJQ98kL41c3
	O+DUt80j9zQ3njFJx6VUssW8D1IwceDzbm2pQSIbpXrdNvuF8/6Gl0eLSpxR/nY2oYXtE+LuVivEb
	YlrM5W/repD3WFcjbkveNHD0hq63vTZRtYnBbmqWbqTAmmNmGWdwBg1g+cyu0nE2eBTe6r0l4PYXf
	JsnrS8k4h6yX7W5eozw7wnh7y0J529pbdHrjdflId3RaG22bqevtzMdv7DbsDxgwhdPiaNiDf20gy
	/4TxtispRPNuk7t2gglA84axEA2CuhAMLCBwIhjsD6deuQ6iK3D82pNc/Qpz5cbZhHkLRBQgwUOPc
	uF2tILEvt4LVyGxfRLmWbb1mQXPhIvvUMTFin87lBz1wz37bv2iIlC0bK6SGUuVHwxNczXOXWfGGK
	tZ51avsDjpOXYForYUPvVZeTYFKf9pH7Xi8gx5vtFp2XZbUtmEZ+BwsOJSfkvBXERDRiNv5yTmmrq
	TFcouvqGwRmwmV9znLVZ6kDeEO7+dhgIyvHN8CKeo=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 v9fs@lists.linux.dev, Haobin Wu <853555@gmail.com>
Cc: jack@suse.cz, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aneesh.kumar@linux.vnet.ibm.com, willy@infradead.org, dhowells@redhat.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org
Subject:
 Re: [PATCH v3 3/3] 9p: skip over-long directory entry names for legacy 9p2000
 too
Date: Fri, 18 Sep 2026 14:08:00 +0200
Message-ID: <2050867.PYKUYFuaPT@weasel>
In-Reply-To: <20260918024851.51229-4-853555@gmail.com>
References:
 <20260918024851.51229-1-853555@gmail.com>
 <20260918024851.51229-4-853555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 18 September 2026 04:48:51 CEST Haobin Wu wrote:
> The legacy 9p2000 and 9p2000.u readdir path, v9fs_dir_readdir(), parses
> each entry with p9stat_read() and, unlike the 9p2000.L path, never had
> a 256-byte name limit: a name of any length up to the wire maximum was
> handed to dir_emit(). getdents64() therefore returned names longer than
> NAME_MAX that no later syscall can use, and failed with -EIO for names
> of PATH_MAX bytes or more.
> 
> Apply the same NAME_MAX check as the previous patch does for
> v9fs_dir_readdir_dotl(), so both protocol variants behave the same.
> 
> Note that this is a behaviour change for 9p2000 and 9p2000.u: entries
> with names longer than NAME_MAX used to be listed and are now skipped.

That sentence is a bit misleading, isn't it?

Name length 256..4095:
  - before: listed, but unusable (ENAMETOOLONG)
  - now: entry skipped, fetch continues

Name length >=4096:
  - before: aborts the entire fetch (similar to 9p2000.L side)
  - now: entry skipped, fetch continues

But yes, it would be a user-space change nevertheless, so ...
 
> Suggested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Link: https://lore.kernel.org/all/3910569.MHq7AAxBmi@weasel/
> Signed-off-by: Haobin Wu <853555@gmail.com>
> ---
>  fs/9p/vfs_dir.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index 08d1a3429654..31de9ac913f0 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -119,6 +119,8 @@ static int v9fs_dir_readdir(struct file *file, struct
> dir_context *ctx) rdir->tail = n;
>  		}
>  		while (rdir->head < rdir->tail) {
> +			size_t namelen;
> +
>  			err = p9stat_read(fid->clnt, rdir->buf + rdir->head,
>  					  rdir->tail - rdir->head, &st);
>  			if (err <= 0) {
> @@ -126,8 +128,16 @@ static int v9fs_dir_readdir(struct file *file, struct
> dir_context *ctx) return -EIO;
>  			}
> 
> -			over = !dir_emit(ctx, st.name, strlen(st.name),
> -					QID2INO(&st.qid), dt_type(&st));
> +			namelen = strlen(st.name);
> +			if (namelen > NAME_MAX) {

... maybe better if (namelen >= PATH_MAX) here for legacy 9p2000(.u)?

> +				p9_debug(P9_DEBUG_ERROR,
> +					 "skip dentry: name length %zu > NAME_MAX\n",
> +					 namelen);
> +				over = false;

Nit: alternative would be init over = false and dropping explicit assignment 
inside loop branch here. But that's already personal taste level.

/Christian

> +			} else {
> +				over = !dir_emit(ctx, st.name, namelen,
> +						 QID2INO(&st.qid), dt_type(&st));
> +			}
>  			p9stat_free(&st);
>  			if (over)
>  				return 0;


