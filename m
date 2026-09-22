Received: from mail.planestimations.com (mail.planestimations.com [45.92.8.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03B33ADBA
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.92.8.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129567; cv=none; b=PZCb0hrwO65VrsRVc3XvuPSzVgRf/e+8KKNfrgdq5wJV9NINmd0CcCsg4z7kghFoUa9+huEIfPyVcDUCAEIn8wwnq3+qCA8H1kviy/yewbAThmis7krrJzK3PwlgHqx9ZNN/qCjVDWLl6frEj5uyx4Ihl+btYN2jemj/jIaz+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129567; c=relaxed/simple;
	bh=5mo4a8D+92hDS8SCSV82vwGIn5ZxVNHdESGLgSE0M+s=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=EMOY3R0gP2afV7MdrGotHDTNLCY388o6a7JMcrpOfN+f+/sEi0LmM8jReSxp5NFA3Me10UiShJFtNkFenPWNDDRToJP0T6PBOVlWa8NHOdZdDzxkvPxo3T93zBZSYEMIk3NgIdWi6ESsxTPEtTuo05u0YMLmxPDgjOVjE9n5A70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com; spf=pass smtp.mailfrom=planestimations.com; dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b=MZSbVwU6; arc=none smtp.client-ip=45.92.8.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=planestimations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b="MZSbVwU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=planestimations.com;
	s=202505; t=1790080387;
	bh=5mo4a8D+92hDS8SCSV82vwGIn5ZxVNHdESGLgSE0M+s=;
	h=From:To:Subject:List-Unsubscribe:Date:From;
	b=MZSbVwU6MCv1ARADPhXjs+yOcF01VJcmpUbTqUiAzSS0Os8Uniw/XZ/N9ANRhLKb1
	 Aic5R/h6dlWY06UNvaKLsCqFmjdcBVz3WkdLpcNI/fvvKWFZYGCHVrbl4HSBGRGfjR
	 GxhJhaFX82c6VPwjVLXijGE1IQvNZZ4jfp6tVACv3md7iQ8wkRuE/tAK4Qrc6BF97O
	 2xH1kKlFhewY+VFEI2eIdfzxmQuluugkEHBoU6Z9ECJvvDrQwXU2IjzZlJ1u+hUk1p
	 g1qBBpyOcvIjkYdw7nMVCjUE0WDx2faeyIrfsAWpaHwyl0Z7rsPDUkWf2XRNinGNSp
	 RQG9WsnGks0Vw==
Received: from [127.0.0.1] (ec2-98-93-79-32.compute-1.amazonaws.com [98.93.79.32])
	by mail.planestimations.com (Postfix) with ESMTPSA id 2D986501547
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 14:33:07 +0200 (CEST)
Message-ID: <c25d4d3c-49d9-4c82-b40b-81a11361ecdc@planestimations.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Jane Wells <janew@planestimations.com>
To: linux-fsdevel@vger.kernel.org
Subject: Precise CSI Cost Takeoffs for Your Builds
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 12:33:05 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

We specialize in accurate CSI estimating solutions for developers working =
across residential projects.

Each estimate comes with thorough quantity =
takeoffs and structured reporting to help improve bidding accuracy.

Feel free to tell me if you=E2=80=99d like to review a sample or schedule a=
 short discussion.

Jane Wells | Sales Representative
Plan Estimating

Click Here to Unsubscribe
