Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49663305693;
	Mon, 15 Jun 2026 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781561653; cv=none; b=JlAlpUavFW6n9GkB4+U0XnLscSz+gthlxBqFf7bxlHOYzfxrGwAGq+HkoX0+JgZXFIoA0YAJLkag4docBbQ8ZrxMVI/G91CbMXXuMuGlRTjr38SdenWvQ6hFJKExC2YJcIy0vNIWQv29hmgwNTEQcG7Cm5F4uzx015nX8380N0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781561653; c=relaxed/simple;
	bh=sVprY7PouF3RmhfTPbrq9rGf43UMc7bxrzxuhZsvCJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3irPf5SAqSlN/Te24zNvQv6km+d92P44+GPR12YRklusKKevWYJ///2tqMCVf14fkWXJnr2DT2H5SntI7/MhfKzJtmv+sX25DDWUMY1vvx82VOg7cwZhGmIGQjfl80IF7wFp85hbptybyXgHl9B9RzPPKgscWmauA33X4onobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiPAPa9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiPAPa9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63431F000E9;
	Mon, 15 Jun 2026 22:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781561651;
	bh=HoY62TWG3USyfrv4K40Mof0mBqYsQixr2LFxTUwTjFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UiPAPa9zcJMm0tSx74C2rr5+OJCf4YeK4rcnIyhCzGd+2FeXf7/TGpxxNpVhERTsD
	 fvnCZxh0wV0adIZGVZ8uXXC3fhp4xq0Ilhn6F06MY+NqcBQT9/Ufg5wzm/wK2YnaHS
	 azN34FXtsdcFP6WBL5LMGVCUqeHeSZdNm4VK8c77Ypwsx93bDZRTfcaNEk35yr3Rma
	 OLCy3XFAIZ9PT3nRyrBtkSn3q/9SxeeG7yZpobLMRG8mhQ13VWBFxBG2hXlN4o+z4U
	 eXqABT9u1Rjy1UcCFb56N1UOs25PaqcYhJ1Iou76VTWPEGJlEtvcByFOL0DjJsOjuj
	 RjcT8hADPwoxQ==
Date: Mon, 15 Jun 2026 17:14:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-doc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	puranjay@kernel.org, usama.arif@linux.dev, philip.radford@arm.com,
	devicetree@vger.kernel.org, souvik.chakravarty@arm.com,
	linux-kernel@vger.kernel.org, jic23@kernel.org, elif.topuz@arm.com,
	lukasz.luba@arm.com, sudeep.holla@kernel.org, leitao@kernel.org,
	vincent.guittot@linaro.org, james.quinlan@broadcom.com,
	kernel-team@meta.com, linux-arm-kernel@lists.infradead.org,
	kas@kernel.org, arm-scmi@vger.kernel.org, peng.fan@oss.nxp.com,
	linux-fsdevel@vger.kernel.org, michal.simek@amd.com,
	brauner@kernel.org, etienne.carriere@st.com, d-gole@ti.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, f.fainelli@gmail.com
Subject: Re: [PATCH v4 06/31] dt-bindings: firmware: arm,scmi: Add support
 for telemetry protocol
Message-ID: <178156164845.1820518.478350687908291764.robh@kernel.org>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260612223802.1337232-7-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612223802.1337232-7-cristian.marussi@arm.com>


On Fri, 12 Jun 2026 23:37:36 +0100, Cristian Marussi wrote:
> Add new SCMI v4.0 Telemetry protocol bindings definitions.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> v4
>  - changed protocol number to lowercase 1b
>  - fixed misplaced block for protocol 0x1b
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

