Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3003655E2;
	Fri,  3 Jul 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066162; cv=none; b=FqSLRTl45tIe6taoxZcZwK9C7hU6hyZvjVpZiUVfQoU+EcIWemYs9nXRbJ0en8aL1CvD2K1QN8ESCyKVoKQJLQXlZGqp4NN4+243LbTHixNqctZyNQHcUdVFpx2+zXZs4VMnkSOPUbAk7UJL4X6VQ1UjMpKt/TrX2/zHLX+0Eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066162; c=relaxed/simple;
	bh=S9BXyV05udQ/hHCID7P5amfZugfVKwXtWgXI+MG8+AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/j/L/ECO9J1AyCbHI8QwcCAcafFyIlKqZMilozjzpHzQoCaKPe0DkLx6UQCx5pGfl9CiSlFeJyFndJrZqzbj+VsevoHgJh9RSUAXUICIxsiTtsOmwZkkFsCaPAGmk535toHXgvUog3tCD2eNyLaYeHbYiIYGX4o1V9Ru0MVkBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axecER4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axecER4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A336E1F000E9;
	Fri,  3 Jul 2026 08:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783066160;
	bh=SIEmNk45zTtgwkOp0n4jdIr85VqxwB6JyzY1Q3tUzXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=axecER4fJmtykW0nvcQnViaUeg3V8Q9YYMA9YvXxkpGA73cS/9zA14uBqGY3+AQUi
	 +31tcfJBbCJVa4tgf8OSuqtOUR5+4ejIu4owrs0wuszZSglVH7CbDGRaUPKhcxJ5B4
	 WrfmNmQ+LjIZAkiHQc5F0PrNNFdde3dIKol3nHOQfBXRYBSw1rqbq9hgsLHxQh5+qG
	 NEWggfVG5JbDhSbN5Xg1tNsShv5enrp/qdMaBn+Tz6L4P2AQhSwz6zp0K1q4k1bFZ2
	 zr4SpHchBNuDDEpgmCUxAYGPFX89qJDhh7DYx25WOhDMVTAZJz4eIOezqIIlZnZmlV
	 qkBM3+tXnrSag==
Message-ID: <96141a02-b845-4f0f-a351-473fc7698b69@kernel.org>
Date: Fri, 3 Jul 2026 10:09:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: link AI coding assistants and tool-generated
 content pages
To: Lorenzo Stoakes <ljs@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Justin Stitt <justinstitt@google.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>,
 Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260702164901.121128-1-ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260702164901.121128-1-ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 18:49, Lorenzo Stoakes wrote:
> Both of these guidelines are complimentary to one another - one specifying
> guidelines on AI coding assistants, and the other specifying those for
> tool-generated content.
> 
> Since they are complimentary to one another, provide a link to each in the
> other.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  Documentation/process/coding-assistants.rst | 4 ++++
>  Documentation/process/generated-content.rst | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> index 899f4459c52d..6125ee4914c5 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -15,6 +15,10 @@ kernel development process:
>  * Documentation/process/coding-style.rst
>  * Documentation/process/submitting-patches.rst
> 
> +For guidelines on content generated by AI coding assistants see:
> +
> +* Documentation/process/generated-content.rst
> +
>  Licensing and Legal Requirements
>  ================================
> 
> diff --git a/Documentation/process/generated-content.rst b/Documentation/process/generated-content.rst
> index 08621e50a462..aad2caad9f8b 100644
> --- a/Documentation/process/generated-content.rst
> +++ b/Documentation/process/generated-content.rst
> @@ -107,3 +107,10 @@ the resulting changes.
> 
>  If you do so anyway, maintainers are entitled to reject your series
>  without detailed review.
> +
> +References
> +==========
> +
> +For specific guidelines on AI coding assistants, see:
> +
> +* Documentation/process/coding-assistants.rst
> --
> 2.55.0

