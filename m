Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297143CE52
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837511; cv=none; b=VkDS9cmIt7+p5xFN1MY4YV50OCZzF7MmiSfvzKfLG//mYFW6l/tvPdHIBsgLiLqUAebkr2P0GvJ9thQ7AEO83HcCAW/RqHTF5ailQJeJMySVuVVy3DHWMADZm8Njmj9U5TfTpyMRHwPlCxyJogpx6sbafF4RvGsqeKb1/vww11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837511; c=relaxed/simple;
	bh=IXYaG4ywu309Kv4wkvZjIaLkoaCBeCVGjvb81+00ero=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hrHVz6esZW7Bg1l/be6VJdPXqqy1M3dHZUU3cNedUAqAvUPAN5Xb2gJVYrTOt7BlxUADkPsl7XHpcqHqV+D7JWmtZh0n44xlElM/scK89mJ2db2s6QuoLkagguKF6oaM/m3p9GK5zR1Kxw67A2VxlZdhvtGoJyugZrhMT6xIBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/ZhEZLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/ZhEZLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364691F000E9;
	Tue,  4 Aug 2026 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785837510;
	bh=m4o4wsGMHFoMKmCRlxicN4et5cqaz0/Lf/N40da+z+M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=P/ZhEZLFa2dVHRLWGQ4jZGXc0BxBptMWk5T3Ny+7Fw1iJCFS4IejlDet/0X7ZTyG1
	 jyNi6XoRoi9cgv5QBkEJu0gjiSpegW40wR16klAsR31KUNVZypFI1oWqyCqZyT/6u6
	 A8kV/+F/r1oOSEdQIAANCVgg18HVlQ48uFcV/J1nO4GHhIdUmAwFgA2UFbRg6aR36y
	 1NURQhTOHiumq8NCCtTwsOnfW/oj+NLgRJxVc4dNkV71U8FycCsTYKNL4DrvjuDsKp
	 d3UE7VSAhklumIsiv+twqZ8QBh3PUzuSp712jM9ruXASYdW+NS406XXJVwgIVfoNc1
	 HIRUtKRPPVudA==
Message-ID: <1d44be0f-7e38-453a-85b2-56c29d9b73c6@kernel.org>
Date: Tue, 4 Aug 2026 17:58:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, xiang@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org
References: <20260804055949.2927896-1-gscrivan@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260804055949.2927896-1-gscrivan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 13:58, Giuseppe Scrivano wrote:
> Allow userspace to pass an already-opened file descriptor as the mount
> source instead of a path string.  This is useful for tools that already
> hold an fd to the image, such as composefs reusing an existing erofs
> backing file.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Reviewed-by: Gao Xiang <xiang@kernel.org>
> Acked-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
