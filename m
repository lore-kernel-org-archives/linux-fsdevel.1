Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381471;
	b=CTIm6vC1mmcab35FbxPz4iiQmj6Mndu07iyG5if+pgsLpRg5vsfj5oDkpvMxvJ6xl/sg
	 WzERdEe9IDncNyksX1WUiEtC/r9LYKy7+k+FMvJpG3QpV/X+fxxO5mH27tzVaEyovKEdR
	 eLuhKIVWrfNjNqoK534/HoAQCHjDdqgMhOi7osxEK153SUT4Hv+3i/1MSd8bckVUzfNKv
	 qaXd3EWfFrB/AiidkTD6c3zz/h+INh6q5xyXOmnKCl5V+DBiSfPq+9C5eeAFXjrMDzMQq
	 ivlQC4+1dYOtKUpcn/XYeqMjAUTvfM590XqevkqgsJovvmR6foWkc7Q1qKPELAiE2uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381471;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fg7sBIBBIZeKWJ8/JYY346gWQ9mcOTtew5ZMnNDXvPo=;
	b=yikjIfK9pDAjBiUo1rkTYAPf0sPcOMi2pf+NCFQZrWctExnvDNESAtRn7w7RylWRHs10
	 PETojZnpLBtQDB5Lu5Y6xfh2GXBpHikK3fXtqoLK0oPm6E/ioNkB3PrWmZZsvZI+B492F
	 FHHHs5QkdBSwXQtqAXtU+LCL8+13QlAfTqI625Udzh0frJ3pIB+CRJ8a4AQ7gy8RN6wMD
	 3M4oGmEwiXkZIhdBSZrfM44r/Hc/kI0F36TCFg7/Egc9e6YeRx5hTwfLviyXbAI9AE6R5
	 7czfuO1SC9bWUekJyJA5y+LkKaVhroW+Byd/kyXHycslOxkx7ac0x2mkFH8RpUtESLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmogyahR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52345606A324;
	Wed, 11 Nov 2026 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmogyahR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29F61F00A05;
	Wed, 11 Nov 2026 07:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794381470;
	bh=Fg7sBIBBIZeKWJ8/JYY346gWQ9mcOTtew5ZMnNDXvPo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=QmogyahR2S2S+50NxZugt7fuY4axtg3ueDQSY4W8/10+kK5FqEDnuRKiqCJhjjA3W
	 sS2UI+NlgNe2HyT81vxGwW6Pc2XLnxY0B3zyAHIDXhuoQxDXogIwD+jTkVmbcaRtKP
	 lnSKE93RpH+7VNrFhWAcsGelWnOcCmwofy+IkF/v+a2XZ4x9Opf1MbfSLTnTMKiXfy
	 eQupF69MsyuWhssMB5fbiSqH5zgWwypCposzpFk4mYeXI9WtTKu+928pMME7IFCRPK
	 xCvhlkEdE6XBAXHwSVcxeHtcqXjE/saTJVutDNnGqiRiPEMfgJiOl3MUEg8bFYSaaY
	 +gbzg0MBZSjpQ==
Message-ID: <7547b1e5-11a0-41b2-9762-f11bf76756ce@kernel.org>
Date: Wed, 11 Nov 2026 15:17:48 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] f2fs: fix various ABI documentation issues
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
References: <20261103033713.2709978-1-rdunlap@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261103033713.2709978-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 11:37, Randy Dunlap wrote:
> Clean up the f2fs sysfs ABI documentation:
> - use "number" instead of "#"
> - use "seconds" instead of "secs"
> - remove an extraneous period ('.')
> - add a space for better readability
> - fix grammar, spelling, & punctuation
> - break up comma splices
> - use a list for "gc_urgent"
> - add a blank line for the list in "extension_list" &
>   "effective_lookup_mode"
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
