Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BB4E4C2B;
	Fri, 18 Sep 2026 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729655; cv=none; b=R1PYBWsQH9vXvUeYdVeObooVaWEP2/G3KEIdee4NdwWtDn0zHj5n5f/AMCrw6zQQ3WgiXDgfoYl0KhzeP6+XARgckQMlaB3XahJzfxPYGPIN3WJa3DrdLbjDcWqxP0bYMMsh5L/yFK4Cr2FDy5naQx6sAbZIwvsD60q7aufSphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729655; c=relaxed/simple;
	bh=uEcZUe9RzTzScYBCvapTtyu1X3UMlG9+8b6Er10mQlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EE3JtJcPVnb6pYAye/VZQdZ8E8lcCkaEHRFPn5eLAgB+hHspYc493ghtQlxcFyvb5+h1QZ6CEcpeCSX9e8edB5Id0ApdA54H53wFz/WB54MyyOTOU0zz6e+dasZYii9qhDNyCVGqWuuHrZgc++ANIuOzcUnIlDwAz569CXNqJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=HR6YKorb; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="HR6YKorb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=uEBFH40ySP52gMVi8KeSDDnEIMVSWvNo3SjFokXECUY=; b=HR6YKorbEaUJEQJmZZKuvqRxtQ
	bHY96zijWGWsEzme6g7ojKEciuv0CSUG9iaER+QOJhg+HvWb3Fr9Ng/vYLMrM65YvGavLfyPfeD/J
	/rYoUavrruqe8VNDB66uM8DNYXjnsBk042kMp5qlTKEOQ9BI07h1hMgVyFwAxiZT/T2tcfngklBuU
	MH1Powevsa0zd+sWxRtT5TQqsaQBFruMxxbZEAAWVQc3nJCmG0/znPyRIfUprFdoX21Wx+Gn+ipMs
	94FWio+ULazt+6k3rcHYtn3UDCZgZgBD37pRh+gCuROI9bmZ+v/O2hS6KZ82AyHaQ+zFK8sEdG9Lk
	JpL6WcGq3YwpGFd81kH93P/m9z1YUzVCIe7s0zY4/Zi/y4TDiL/1DhRoAMsJ2FTrW6I6egsEo5WCP
	rCdgesNU08Mm/0k0yLbxxxhSkIyF3CgYhN7akGayYSJUXvhTaPU8G2YtXkvunKY2wNiHZCUgA7vJX
	pLNVZUL6YNBCuVhfG9+c/NA74BMCvuYQkD7nFdsUvKVPhe2jPzVYoOIwgI/mEY5CB+fI+nSaJrI4W
	R0/u6+X4CGbJR5ZC+pDQT0BIjy0AJ/IJrb41uC8tmZMSsO+i5peOTigmjp1Asc97Fdh1LtW4WOHOM
	gGoJJBOnwz82CmGNkNKmuw0s3//owQI9+S50nt9QM=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 v9fs@lists.linux.dev, Haobin Wu <853555@gmail.com>
Cc: jack@suse.cz, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aneesh.kumar@linux.vnet.ibm.com, willy@infradead.org, dhowells@redhat.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org
Subject:
 Re: [PATCH v3 1/3] 9p: skip intermediate directory entry name copy in
 p9dirent_read()
Date: Fri, 18 Sep 2026 13:07:10 +0200
Message-ID: <12972173.O9o76ZdvQC@weasel>
In-Reply-To: <20260918024851.51229-2-853555@gmail.com>
References:
 <20260918024851.51229-1-853555@gmail.com>
 <20260918024851.51229-2-853555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 18 September 2026 04:48:49 CEST Haobin Wu wrote:
> v9fs_dir_readdir_dotl() decodes each entry of a Rreaddir reply with
> p9dirent_read(), which parses it through p9pdu_readf("Qqbs"). The 's'
> conversion in p9pdu_vreadf() already allocates a NUL-terminated copy
> of the name from the wire buffer; p9dirent_read() then strscpy()s that
> copy into the fixed 256-byte p9_dirent::d_name and frees the original.
> 
> The wire format carries the name length in 16 bits, so a name longer
> than 255 bytes is valid on the wire and may well be valid on the
> server's filesystem, but it makes strscpy() return -E2BIG.
> v9fs_dir_readdir_dotl() turns that into -EIO and aborts getdents64(),
> so every entry after the long one disappears from the listing.
> 
> Drop the second copy: keep the string allocated by p9pdu_vreadf() in
> p9_dirent and let v9fs_dir_readdir_dotl(), its only user, free it once
> dir_emit() has consumed it. p9_dirent is a short-lived stack object, so
> the string's lifetime does not change.
> 
> Note that the VFS only rejects names of PATH_MAX bytes or more in
> verify_dirent_name(), so after this change a name between NAME_MAX and
> PATH_MAX is returned by getdents64() even though any later lookup on it
> fails with -ENAMETOOLONG. The next patch skips such entries.
> 
> Fixes: 7751bdb3a095 ("9p: readdir implementation for 9p2000.L")
> Closes: https://github.com/microsoft/WSL/issues/41192
> Signed-off-by: Haobin Wu <853555@gmail.com>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  fs/9p/vfs_dir.c         |  6 +++++-
>  include/net/9p/client.h |  2 +-
>  net/9p/protocol.c       | 12 ++----------
>  3 files changed, 8 insertions(+), 12 deletions(-)


