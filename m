Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377638;
	b=xf6MKO/Vv6ls+QEtTvBcVGxnC+ATi+6rut8Qn40H5K4Rn1Y9moYWeC9wY2OizeV3ktAm
	 jtio5h64mawi1XSnYQQSS0Y7ec2yzdyhwKABLgpsPvjThL3z7KLxO+yfol6OEZsqk+vJa
	 pC4FHRlFMRoBNZ78pBI0QVhKhZy7ZeqSLFjQfCl31xdNhwSAJW2U9m+zdzAUbGh8jhqak
	 Pvw78n8RnWwY543nM5DgUUqsNtFyQ6h82i9qFteMbRDKMAApTDCAy54CrUa5StKqJQJxW
	 KzEZ3ZxzBttYcydPK7Jmsp4E8SKxGBBDQhDOF1NS9S7Rw/MHUaE+LfF8eipS3UBBeSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377638;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BApKk9bvm1amKduE4XKHeVMRqoESMKreIq2yBi+WulU=;
	b=LvH2PZLkO5AkWmlYT+XYLOltk5xWOlbA6RoqULKBz+fQFd7NA4tSWNOyfbRG5S/w6yYs
	 zNkz3IC4CLEK0Xf1H8cqAomhXS5sM9+HYfCt7Pij+a86Oqd+wj3Ez5121fKepe02rILSK
	 pkFqHu2BANmYdvlAFmtFJSiw0VDzzCQwRWlrJniQcDLznLGQhnbH7DgxDrup767XXJi+1
	 Zg93SyxAGZs6q6mBKeYAeRGBOxy4XtuCSBwSgYJmc6daqPt/w8Sp2uR//E3oRf2yAFGU0
	 krwCdc8Iq9VxvZGyAaGyHjz3MZLxOtXOlefj4+4iF9L4OIjn3qqpYp15KzxIOuV8DyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhw4pysz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97F606A31C;
	Fri, 30 Oct 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhw4pysz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF241F000C1;
	Fri, 30 Oct 2026 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377638;
	bh=BApKk9bvm1amKduE4XKHeVMRqoESMKreIq2yBi+WulU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lhw4pysz75olCzPtQJgcGeW2YwRObY4POBWg1Gm2QxZxFT0cPXoWkn7Ig+TJhmVtf
	 ahjgdz4rbhZwXhu+vdL8O7mJCjR8cg8BlwsG9YJzxtfuzzW51s3Dy1CsxMdGUlyJ2m
	 SWShO/Agh/a2qHCc+LwB11h1D18MiLp1ArWUmR3oJWsPr26Q+YWxYXyOuS/pch0s4K
	 sjmW+8zHhMQPD5NAOnWPLhqIfyHtBRp+Fan5loJmTuKXXQK3Tz3QlkdFfSFCWyLpTf
	 L141NPBjNZ9gqFxqnKE2ZcUvgHAc81KE0Ogtd7u5r0zqOAOfVTpcrRy1U0OXEbUbiA
	 YNFMAuACBK13A==
Date: Fri, 30 Oct 2026 17:27:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Marouane El Moufid <eun0us@espilon.net>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/freevxfs: reject immed inode larger than the inline
 area
Message-ID: <20261030-gedacht-edelmut-erbringen-476335ab411a@brauner>
References: <179296581973.931625.6479067928730594410@espilon.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179296581973.931625.6479067928730594410@espilon.net>

On Sat, Oct 25, 2026 at 10:03:56PM +0000, Marouane El Moufid wrote:
> [PATCH] fs/freevxfs: reject immed inode larger than the inline area

freevxfs was removed in v7.3.
