Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A51D9A66;
	Sun, 29 Mar 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774805498; cv=none; b=Axuw37NAxf4REiaEf04fsKhOP0x2womsVSt0cVwv6TMRwFu6pbCklB8j+MWys2dhSweN5YRsO59KP2KVeWZsFit7kFnl1WtofVc2SVQ/HXoL5Qj8d43Hh09hyZC/0lkEyQpl/ymGnHa9r+vf5TWXvdVXvlNMdQlw7zmh/aGzwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774805498; c=relaxed/simple;
	bh=0spV8j4F14bXIHH7uNOOGSi0WTG/8MloA5eb3snxq8A=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DQQ9852lXlaVTO4QEtqNRkeMfo698hWjGS9taTpT3Kvnx/aMAunu/p57AadIJL1lQlrnZVJ2z3byxGoJ358hqmYUxd6ymh9BOHXylDfH7Fb5Dm2xGJW2HGaR2r+ZIYpcexLUEurGryOcQn73lo78ZvU4cj4KEl46DhxQDQHKelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMIqyvEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMIqyvEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAB1C116C6;
	Sun, 29 Mar 2026 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774805497;
	bh=0spV8j4F14bXIHH7uNOOGSi0WTG/8MloA5eb3snxq8A=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=AMIqyvEAaaYvnkgKoFjiuyxVirybKSG326qn++OCzA+RUMaHqHilt+VnDUOKzvWa/
	 1kqJnzd5LAJv4wjVP0a4NLPfEtGXUF70DmiDnUZkogjQs4BBTk5/CzAd7zCMgtZAhd
	 n6I+dDw3sev2swgL4zXrTcj+akxz1OgwC9HVn3YJAo6gyiofEpRQt5udGsGLw3DMuB
	 q5fjVi0eF6cHylcnewzu6rNOTG5z9/WvKtuIK+WTf8dieQ9IUuOdluYTplZR7pswM1
	 yYmGcpHNdDauU+y8C2rocCbmAUjK8Ld8d0tVQYF/foD5iFqAYahDID+FuREAXKcJ2+
	 0WnRyw0fAXjjA==
Date: Sun, 29 Mar 2026 12:31:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: etienne.carriere@st.com, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 d-gole@ti.com, linux-fsdevel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-doc@vger.kernel.org, 
 f.fainelli@gmail.com, vincent.guittot@linaro.org, philip.radford@arm.com, 
 souvik.chakravarty@arm.com, peng.fan@oss.nxp.com, dan.carpenter@linaro.org, 
 lukasz.luba@arm.com, arm-scmi@vger.kernel.org, sudeep.holla@kernel.org, 
 michal.simek@amd.com, linux-kernel@vger.kernel.org, 
 jonathan.cameron@huawei.com, elif.topuz@arm.com, 
 linux-arm-kernel@lists.infradead.org, james.quinlan@broadcom.com, 
 devicetree@vger.kernel.org, brauner@kernel.org
To: Cristian Marussi <cristian.marussi@arm.com>
In-Reply-To: <20260329163337.637393-7-cristian.marussi@arm.com>
References: <20260329163337.637393-1-cristian.marussi@arm.com>
 <20260329163337.637393-7-cristian.marussi@arm.com>
Message-Id: <177480549380.3925363.5137815678176793743.robh@kernel.org>
Subject: Re: [PATCH v3 06/24] dt-bindings: firmware: arm,scmi: Add support
 for telemetry protocol


On Sun, 29 Mar 2026 17:33:17 +0100, Cristian Marussi wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/arm,scmi.example.dtb: scmi (arm,scmi): protocol@19: Unevaluated properties are not allowed ('i2c2-pins', 'keys-pins', 'mdio-pins' were unexpected)
	from schema $id: http://devicetree.org/schemas/firmware/arm,scmi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260329163337.637393-7-cristian.marussi@arm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

