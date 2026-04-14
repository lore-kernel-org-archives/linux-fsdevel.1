Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3346117A2EA;
	Tue, 14 Apr 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188066; cv=none; b=qNZO2x+RTna4VIBa84Ljk/mqkrsk04KcTB/888mY/gddzQapNJeKSQHiEiZTdPJK7Hsvn0DARL3cGKiXrkznlAJy78HhxyCbIPc0iLQIusYcXaXEruxjNJn2axGviJi8NAehKD31vJ+Eypv3uNz/jCPLA1tmmnENkAtcTMPU3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188066; c=relaxed/simple;
	bh=RZIJkrt4uTkUK0CCrjlOPMYTyc5t7ImaWmtrc8Kh5vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTVwKjLPJCplUgSKPwvu88r3QRdaEjXsLXb0lSAK+J03x+NDwkgXWp5FGGCPy2uY0gOMeln7Al8Xe1wory3lRYQK4fNcVj2Qytvkev9fBOd9Ix5X9jse+0IZOwSpr25yYs6D1wi6vMPp9FTiiqqdFnt41qAMA6imMzTHU0e4Iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3A9UrTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3A9UrTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D494C19425;
	Tue, 14 Apr 2026 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776188065;
	bh=RZIJkrt4uTkUK0CCrjlOPMYTyc5t7ImaWmtrc8Kh5vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3A9UrTW5Hyp0LuXchy7Wo4I7zbQ1aSQHmu1lMSW6a5HZyiNB7iQcO0dL0wU28VKV
	 MK/4VmMQi6nXHhYg0k0l1QBsuiz/V1Y0mXn3S6ybt70aCfLaFwNPVAkhGSQYxwk2b1
	 RzragL4ak6K5lbfALOMXHNXkf7JX0vDt5/+tvooWm66PIMKaxEjkmnHG9Jei9p5+y1
	 9/VMLbqpegmmDddKQbWAVruAqyaBKnc642/67hoZtR6U6b5i+2mnXLy37IfKGSNTmL
	 1B0hLdvgUcDGT/eddkZ6U95TULcFDMRgTFxG8gikHW7YzwPVroGdUYY8hLaiLWYzk5
	 7IMk8AZBpt/Lg==
Date: Tue, 14 Apr 2026 10:34:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
	djwong@kernel.org, adilger@dilger.ca, pfalcato@suse.de
Subject: Re: [PATCH v2 08/11] ftrfs: add CRC32 checksumming and Reed-Solomon
 FEC skeleton
Message-ID: <20260414173423.GA24456@quark>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260413230601.525400-9-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413230601.525400-9-aurelien@hackers.camp>

On Tue, Apr 14, 2026 at 01:05:49AM +0200, Aurelien DESBRIERES wrote:
> Implement data integrity layer:
> 
> - ftrfs_crc32(): CRC32 wrapper via kernel crc32_le(), used for
>   per-inode and per-superblock checksums
> - init_gf_tables(): initialize GF(2^8) Galois Field lookup tables
>   (primitive polynomial 0x1d) for Reed-Solomon arithmetic
> - gf_mul(): GF(2^8) multiplication via log/exp tables
> - ftrfs_rs_encode(): systematic Reed-Solomon encoder over
>   FTRFS_SUBBLOCK_DATA bytes with FTRFS_RS_PARITY check symbols
> 
> The RS encoder operates on sub-blocks within each 4096-byte data
> block. Decoding (error correction) is not yet implemented.
> 
> Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>

Is there a reason why the kernel's existing Reed-Solomon
encoding/decoding library isn't being used?

- Eric
