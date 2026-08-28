Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2641C6A;
	Fri, 28 Aug 2026 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896782; cv=none; b=jVv3zTguprpvZ4qDDSwgj/aauKEfZp4++2lnPD97TzeVmtTn0tgWn63SJLK41luiLrlEpayOWW0fOXQYkaHfj5kPPcLT9pfvQdh1kbtAg9b9CJU2jy61uRLh7AakLWpRHFz5jzcf5mGeHqiGNTKeoicj2iV1JG09Wx46D3JKCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896782; c=relaxed/simple;
	bh=QW6OAfEG4jr0MAWRBPSXqUZGyXp19TaDRd1o4dPxkdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH9w+DcxA3xRdaQxWG8btzzKfXLTZNbL9ypg7fL8IuUVxs5MgHyi/CQz5lZdv4OgyTA0t4SFfKqpPdukdLgt6wuLznXdit2lShtxDxwyKCshHJHjPRjMamZ4YFwYiw1U0H6Lr55/qsn7uBiDbyr/ROBE6H4r5FHIR/CUFVdNHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kMRfq2FN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kMRfq2FN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4871F000E9;
	Fri, 28 Aug 2026 05:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787896781;
	bh=02X5qxpTn+acXY/d4ysF3a2ACGU1QzQeKto9BsXSDrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kMRfq2FNLBytve5064SIDTzaXz3iF4ibfizfyHv1DMgmphCI20hNhIdp5OL5ZoOY0
	 OkqKv0yfdyxPw+7q/VRYYgjm5r7OYapz0q78Nfuz5yXBMw9y7gv5am58F7UqI78D6y
	 A1ui/qJSxSxUcdL+T2pky2W9z0Uf/sF+oxLRn3f0=
Date: Fri, 28 Aug 2026 07:59:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, falemi@asu.edu,
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] general protection fault in sysfs_do_create_link_sd
Message-ID: <2026082813-rephrase-superjet-82bb@gregkh>
References: <CA+0ovChyLaYfEN19Fomt6qWx6dYtX47Ptyaej3gfMeNGB1xoFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+0ovChyLaYfEN19Fomt6qWx6dYtX47Ptyaej3gfMeNGB1xoFg@mail.gmail.com>

On Fri, Aug 28, 2026 at 05:50:00AM +0000, Farhad Alemi wrote:
> Hello,
> 
> As part of the kernel research at ASU's SEFCOM
> lab, we hit the crash below. Crash reports can be found here:
> 
>   https://github.com/farhad-alemi/public_bug_reports/tree/main/188-general-protection-fault-in-sysfs-do-create-link-sd/
> 
>   Oops: general protection fault, probably for non-canonical address
> 0xdffffc0000000006: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
>   RIP: 0010:sysfs_do_create_link_sd+0x4b/0x110 fs/sysfs/symlink.c:35
>   Call Trace:
>    sysfs_do_create_link_sd+0x4b/0x110 fs/sysfs/symlink.c:35
>    nfs_sysfs_link_rpc_client+0x3a3/0x590 fs/nfs/sysfs.c:343
>    nfs_init_server fs/nfs/client.c:770 [inline]
>    nfs_create_server+0x7e8/0x2110 fs/nfs/client.c:1155
>    nfs3_create_server+0x1e/0x180 fs/nfs/nfs3client.c:56
>    nfs_try_get_tree+0x1fa/0x11a0 fs/nfs/super.c:981
>    vfs_get_tree+0x8f/0x290 fs/super.c:1754
>    do_new_mount+0x341/0xd80 fs/namespace.c:3834
> 
> Our reproducer.c is available upon request.
> 
> Happy to test a patch if that would help.

Please stop sending random callbacks, instead send proper patches, as
this helps no one.

thanks,

greg k-h
