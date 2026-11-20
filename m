Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180833;
	b=UgDK3SiNtPLY5z5Fuh8VSZhjax2LQweYIU8sg5dUWgi2wMaKdIfBBw/vKA5uaEC5SLDT
	 u6/P0ualBAkkY/LXgZ6iQIGd5mFO4Vp2jQJcH/NrHVWG7w6FWuNcfwjiYex12qbslSnIo
	 JuJIXryvZOwSnezL+QXkmKC0WLrK7LE+kTqAvFlhBbZiaL6BtxOqT3IFvBDruJJJONeIx
	 t2VEiMHKhG7Lhh80ckVsJe3D/sZflKxvj3Ht57l8ZW2NfZZualIiWoFJ76kdwlBDSPG6x
	 72BoEA1Uf4jccC6OHJyqhU2rSDt3JoPNoy3sSU1+uA8Lm4g82n5hjcIBBM3q/dTGYeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180833;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PoxpARakQzjd3CkiIIVbn4A3bEcoclbH5nuuP3ZPgJU=;
	b=pR9ixxI+vuplcAe3fvf9sl/wuG5eR8vrjitdNeXK3wVarIXLjH2bXR0gYeEtIWYNQoy7
	 i/58UdOjLhjQzOGvbawF87587lvnHWSCpBNYGu26Nt3L7LlUojXmuomnMyqxcrgSoYGbK
	 pgA1911u5ZTkO0a8lb9k+aIUjUgogDgUSIXCoOJe9GCQ9GH3i04V6hecW3AAXd7eDcDrS
	 7xXgVSfdTN301zkKy3Gi2+WYBpBGPVvorqgf1EaD+BtypdTzrpE7Zf8HRjXCG28POhCpv
	 1ph8TUK04TmrT+J1x1M9TXJB1GetZVv0IjY2PU50Wh3/JU3Q0css7jrW9W4bB/gKqZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZ3M1YD8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A5606A320;
	Fri, 20 Nov 2026 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZ3M1YD8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E266C1F000C4;
	Fri, 20 Nov 2026 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795180833;
	bh=PoxpARakQzjd3CkiIIVbn4A3bEcoclbH5nuuP3ZPgJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nZ3M1YD8gM9EX0qPeBP7bBwWsM0Shryp/ttkqR9Y5dCbkwnL6fUNdI+s6OwbtUoE/
	 mrtHWnuxYZjptXdCaSavkL4vBlNQORpby4k+LINr2mtpGkZ5tLZdZcRZ8YRAkjbnZ6
	 14OEa0DOyuaFvwdzqqSSsQwzlV8hImVv597+XnJGE0pOcJHhQZlXKNBn4GY2cY/LvG
	 IWaiaUKw0MtTNO/mMoE3hHe2XgGSqrdGwFEktOIMNdjvWrqZP/m8TJZoQ4TfKU48yh
	 qyeSiLWP7YTb7RXBbwcPxFkX4oTO+9TxpOzgJXGAIVI6/nNhyoSXqzn9pCCeH1Z8Eu
	 ogkrZYFkekhVA==
Date: Fri, 20 Nov 2026 14:20:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/qnx6: validate di_filelevels against the pointer
 width
Message-ID: <20261120-bonzen-absaugen-geknackt-c24bd03af152@brauner>
References: <c4-qnx6-filelevels-ubsan-20261031@qq.com>
 <20261117-anheben-kauen-botschaft-efbcb6e18d72@brauner>
 <tencent_8D37DE888453A72965D4A60F43144E2AE206@qq.com>
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
In-Reply-To: <tencent_8D37DE888453A72965D4A60F43144E2AE206@qq.com>

And the mail still doesn't work as a patch. Your note to me sits above
the first "---" so git am takes it as the commit message, and the actual
commit message is between the two "---" lines where it gets dropped.

There's also no Signed-off-by: and no Fixes: although the changelog
says there is.

It's also broken.

Stop this, please.
