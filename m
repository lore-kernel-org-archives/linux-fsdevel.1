Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA311A285
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792655; cv=none; b=ixfKZFbEWBieWoB9zvdvm9Y9vXJvtHDftgco6POCudMyiAgnux8sq9MVFyVzlckNKaOidzPHgG3abpRYXzVKU4xfgUrmXbjfFGTgltfj74XbDAEdKSul7JTm1MrakAzDlypY96toNCCzqehoU6dN92s+ldEUcFynAICHbt2W15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792655; c=relaxed/simple;
	bh=QJqeASL58KChRJCou5KXeolVtav6g0zt+6z28PiF9Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McL+QOLB7fUgsKDjxDvVXMc4B+j0tw9pZTSLwo6LLidhIR4PborWrZirNcx9IfOu3QHwwwOcolq66iK5SJoLfTERf42CAQaQf5teyr8JSSX/YVUxjenAH6F/Q5/3QUD9REbHGic/pc7rWU/siWu94NjMZPo3bc9YyKOny6vSE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=h7fg1FKY; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="h7fg1FKY"
Date: Wed, 18 Mar 2026 00:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1773792651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cV5wPNfm1jnNG3vq81tW/9ST/EO+N/h95QHcB+VtVdI=;
	b=h7fg1FKYrdIHLKgabyFY5lCQ3+RaXqksR0mWyEWLXXuCD+LL8jqMAlFqB1fz+DjcynuxBg
	aqnyPFzWXRToVmyGCtvew5Py6+GqqUk1JXQsOLqOwqTKNBl1AecMkDhrZpd/kJqRnR2yS/
	cuyaLRWbGVz5/TWyhnmDp8+K1b4a79BNIbq67+dVMsd7Awnll2xkkt1vClz4D3UwoLq1vl
	CDyqr57v7D10VOqYKUYxsfDjKyeq8k3iKGc2zUEAnR1IZKUtEYItowRhRap4teYEteemFS
	vqIiHZB8NZhZEGk3pQzBJUjCsKD0m7V8ne1zs5pTkXAqwkxblfMmWQT43b5cpQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <abntindMnlpodsNj@Bertha>
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 12, 2026 at 07:45:17PM +0900, Tetsuo Handa wrote:
> Since is_valid_catalog_record() is called before inode->i_ino is assigned,
> 
> +               pr_warn("Invalid inode with cnid %lu\n", inode->i_ino);
> 
> always prints 0.
> 
Thank you, I will include a fix in the next patch version.
> kernel test robot <lkp@intel.com> reported that this patch needs below change.
> 
> -               if (!is_valid_catalog_record(rec->file.FlNum, rec->type))
> +               if (!is_valid_catalog_record(be32_to_cpu(rec->file.FlNum), rec->type))
> 
> -               if (!is_valid_catalog_record(rec->dir.DirID, rec->type))
> +               if (!is_valid_catalog_record(be32_to_cpu(rec->dir.DirID), rec->type))
> 
> Because of this endian bug, syzbot did not test is_valid_catalog_record() == false case.
> 
Sorry I don't follow this. How can you tell syzbot did not test the case?
> This patch also needs below change.
> 
> -       if (!root_inode || is_bad_inode(root_inode))
> +       if (!root_inode)
>                 goto bail_no_root;
> +       if (is_bad_inode(root_inode)) {
> +               iput(root_inode);
> +               goto bail_no_root;
> +       }
> 
> Since this bug is reported when "rmmod hfs" is done, syzbot would not be
> able to find this bug.
> 
> And even after both changes are applied, my patch still makes sense
> because mount() operation still succeeds for cnid >= 16. :-)
I agree your patch fixes a real bug. I think Slava is suggesting a fix
to hfs_cat_find_brec() so that it validates the catalog records it
returns. Let's continue this discussion in reply to his email if that's
okay.

Thanks,

George
