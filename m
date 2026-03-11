Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044293CAE8D;
	Wed, 11 Mar 2026 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225488; cv=none; b=ig7hemt1AmwwlTn2vtwUK2OyVv8/988URpLHGxopyRc9XAzUmuktG1ILQVpK4LZAVcUScNd2Kvn6/Z2/+0tq/wG6uBu5REMPNs6DQs4SfwHn2zXeH3Qjxd5NPAn1lyk4CxfkU4NLgP3fcwVkqlMGeIc5R/NxrbnzBxKONr1mK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225488; c=relaxed/simple;
	bh=e013IK0Ms77Ip/bpM+qie8PvXORmATbT13XPsa9RKEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SuB06YUt3GESRpuJwciw79WOjbnUr3kxDCy+WIKbX6WOAxEpOhLxmKMn1GlErL52v++8S00ue2+IOiP5RzLF4hmRLDlmoHX7wKzvQtmIg77wKwT3UEmZIjjlOdI+JeEEkC6y7vq26IE5fiVUYygrKPWqIY/izLFXeHdmdZbUvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXeJTLUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXeJTLUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C12C4CEF7;
	Wed, 11 Mar 2026 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773225487;
	bh=e013IK0Ms77Ip/bpM+qie8PvXORmATbT13XPsa9RKEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iXeJTLUefjOX1+Jad2Fp8ms/6o8+zMVEbOUhJk3s64pccSHphmnmJ9mUJy4hycZJ8
	 gEgqeSdHhwhrg1kKUQ5Eijk59zB1s5gsH0BxxRYGEAtSGCog7xnKCHBC4ex3dfq6Tj
	 R2MNZjVUAkVILm7m/XAm+B8WcLTEX+Eb4u6tT10FK8+Y8plrK/qvGvQkUJwvvCMuPb
	 eDxuUa3qseVr8jL0ZIpDefmyYqe/4HmebsLDReJyuDA2DZkH2R+wCQhPxr7QW4c678
	 SxFrmCNEDxkR0KVdB8SjN1x5CeEF7DMd6NFs964iRADyO+qghepikW4z8mHrgVwCtH
	 DWhuyvriarzaA==
Date: Wed, 11 Mar 2026 11:38:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: KCSAN: data-race in __d_drop / retain_dentry
Message-ID: <20260311-stuben-planbar-ab06185adeaa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49420d2.6c84.19cdbeb5e21.Coremail.luckd0g@163.com>
 <2b8b707a.6a35.19cdbe4c889.Coremail.luckd0g@163.com>
 <7852a82.6830.19cdbdeea92.Coremail.luckd0g@163.com>
 <61ff6def.2d0d.19cdad1307e.Coremail.luckd0g@163.com>

On Wed, Mar 11, 2026 at 04:02:41PM +0800, Jianzhou Zhao wrote:
> 
> 
> Subject: [BUG] fs: KCSAN: data-race in __d_drop / retain_dentry
> Subject: [BUG] fs: KCSAN: data-race in step_into_slowpath / vfs_unlink
> Subject: [BUG] fs/buffer: KCSAN: data-race in __remove_assoc_queue / mark_buffer_dirty_inode
> Subject: [BUG] fs/namei: KCSAN: data-race in path_lookupat / vfs_rename (`d_flags`)

Propose a patch series with fixes and appropriate arguments for adding
these annotations, please. All of the races indicated seem benign.
