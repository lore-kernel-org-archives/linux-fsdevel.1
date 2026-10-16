Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44024E06F3;
	Fri, 16 Oct 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168024; cv=none; b=QwCdwCi44wHF1ms5qrk3kO9Dv56PvlyNkUl0h7MFyxgbR/UKPiQIObaI8d3s/ti5z3uXLP2CB0nXYwjy0mfkXf3qN8vOrdtg6MI8ZAoj27ZZF0ObVxq4DRhbP4P4qMbr9dYzpcYipacFgvB/UZvB7lOIHQC/F+LGwvlaZNxQfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168024; c=relaxed/simple;
	bh=k/NnZI6g5iYANsjrUod4ok4m18opjzAfY9Z0VtcxbOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvUFuzfCYgr/VJ4impDLv6oSpPtuXaBpu52AEVWXnUjCs3Lte5VIeGK/UBa8P9oBzmmvQx4923MeBCqszeE4Wh7GB808SGSbcX/WHYA5muczTZ8fvnc4hyAT2h+fOmrXpdUnCpbtHvxJw8mZElS6JLMLSRiTWdSf9CZt2pF2FmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNYUQZwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNYUQZwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882351F000C5;
	Fri, 16 Oct 2026 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792168023;
	bh=2l8YLQbQivJK5RQyiHwvfbhFsZFYdX24H4sZ0vwEvvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NNYUQZwC5/GUrKbCT07RUDe2E13/5WofLyxktdVvu+etqHHwXo8bT9inIbtGbjy4b
	 gO1ljcCU+9K7L6TZXb1ZS+zBf7nibVJGh9xvMH7EvFHxkDDxGZa8IZMBFUIpyiNGpH
	 8YsX+hPeCCaKXTd8cM2Zng2vy4TDJs/EUGZiSwNJRppE3awVI2oDlipUwB6hDh9poz
	 RTQbtOcHbC2vYC4loz7sNAzEpLJ7D/tgcPIkxyAfcPNhRbEw0VFdTEV0P7PLVtaKNV
	 C4lH59yfcU9aV/tK6ml4gFrcGSC8pLURxSfE4Q6OQc6mxDEs/r4omnGgICRGyy8BN+
	 D2sdRUiqnCgFw==
From: Miguel Ojeda <ojeda@kernel.org>
To: gary@garyguo.net
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	brauner@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	georgeandrout13@gmail.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tamird@kernel.org,
	tmgross@umich.edu,
	viro@zeniv.linux.org.uk,
	work@onurozkan.dev
Subject: Re: [PATCH] rust: file: handle fd table teardown in file descriptor APIs
Date: Fri, 16 Oct 2026 18:26:54 +0200
Message-ID: <20261016162654.121877-1-ojeda@kernel.org>
In-Reply-To: <DLM3XWG7NZM6.1B4YP1MC0E3OV@garyguo.net>
References: <DLM3XWG7NZM6.1B4YP1MC0E3OV@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Sep 2026 20:55:16 +0100 Gary Guo <gary@garyguo.net> wrote:
>
> Regular checks are fine, no need for TODO either. Just bring this up to nudge
> Miguel to pick the patch :)

v3 up and ready to be picked:

  https://lore.kernel.org/rust-for-linux/20261016162446.121509-1-ojeda@kernel.org/

:)

Cheers,
Miguel
