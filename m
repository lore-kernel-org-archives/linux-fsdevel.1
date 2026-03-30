Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456D39E19C;
	Mon, 30 Mar 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854688; cv=none; b=Cx0xXE/9jwAcpAdeiPDu7R3olTvKYGdkTjxZdcMP8YWksurFJVkrUAcZ2A2HvDTBZ90S3o36WPkjT/l64voZCUHA3FQgRblFzSBWIKJE6sa+El/9aDd83OXXOlahsH62+iaG3MXeZSPtoG8YnnlZ/bofgKKAd9E4zgqrjuiR2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854688; c=relaxed/simple;
	bh=t8c60sheKpZc2laaTB+QyMe7+0vi7yMHUuQWRlKN5xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBOxF8dj7g3sWVAkW+By606wSfX4qESmM/Ln9iTEO57pXvJo4NY263ZejoRC9qKQJ31zCZckt9m+BHXxFywQZyiJkYA/oKqnhwdixQrnABYy9qI/4aZmyUCKQImWVf2GDOhM3meH/vTMVgBUOFd2ke3s49OPL9a7b/7Kj1X1gIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biqkW+Mw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biqkW+Mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08008C19423;
	Mon, 30 Mar 2026 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774854687;
	bh=t8c60sheKpZc2laaTB+QyMe7+0vi7yMHUuQWRlKN5xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biqkW+MwKIFT62FDhSen26uAsy4mAH6nJRbMyYBYijv8WE/0GmNN+27xd2flh33fi
	 59EMkznou8CzdIUbUbb46Ulb5yypz4q67Y51XX4iraEEAFI4z4p8yEh2aCNoJ0zCGN
	 z3oW501TZZb6/hdGgK21khjx0V8N5UWIDHglbmJmlIrN++mIH22IgnYp6hRsQ6Tj4N
	 3pL9uJBkUYi4ordeXB4mdiUSMmVyjxdP8/2AHsZAJHCw0+PzrwZyP4JRvj9gfUgJ1c
	 9K/UiAzfCZh5Zhveb3hFQJr1t3aMgxHPGR0xmyMFUJhBvjrXl/lgXYPFJ1S3keS/mf
	 Z1zOEUL8uT9HQ==
Date: Mon, 30 Mar 2026 09:11:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	sudeep.holla@kernel.org, james.quinlan@broadcom.com, f.fainelli@gmail.com, 
	vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com, 
	michal.simek@amd.com, dan.carpenter@linaro.org, d-gole@ti.com, 
	jonathan.cameron@huawei.com, elif.topuz@arm.com, lukasz.luba@arm.com, philip.radford@arm.com, 
	brauner@kernel.org, souvik.chakravarty@arm.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 06/24] dt-bindings: firmware: arm,scmi: Add support
 for telemetry protocol
Message-ID: <20260330-large-raven-of-order-bf4e4a@quoll>
References: <20260329163337.637393-1-cristian.marussi@arm.com>
 <20260329163337.637393-7-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329163337.637393-7-cristian.marussi@arm.com>

On Sun, Mar 29, 2026 at 05:33:17PM +0100, Cristian Marussi wrote:
> Add new SCMI v4.0 Telemetry protocol bindings definitions.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index be817fd9cc34..e936ae7c0fb9 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -298,6 +298,14 @@ properties:
>        reg:
>          const: 0x19
>  
> +  protocol@1B:

It's always lowercase hex in DTS.

> +    $ref: '#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x1B

Here as well.

Best regards,
Krzysztof

