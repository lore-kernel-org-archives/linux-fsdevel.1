Received: from sonic.asd.mail.yahoo.com (sonic-euwe4-0022.asd.mail.yahoo.com [34.2.86.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A944119FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.86.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622820; cv=none; b=GrLlSr1Apae8qAboF7Dk1kkQp7axGtma12/xUvxuEb/C30NChRKtWQc7RDiarxhD3jHxB/Np23QZYKRQuV0pf58wR9u59eHqsahAuCoVY5fPR6oG2VyG0hBPy0WJN4IZ7ttWCA9sAExnlXC4wNFKQ8/fah2DAC++z//P4Cywstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622820; c=relaxed/simple;
	bh=yj7nKyFrj7zU2yYnwm4/LaF7qhH6Xk4MypSMzLI7D08=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:To:References; b=BWD1oRhOo3/ghskc8glDmqPxsrtC84cXkS/3jel4ofo3B014SMHx68sP33OSWADb/tgk2IvOxewWDsWH2bp7v3KjKgXKlnX8GTad1W3oE1FdkMiuxZPKeI9+AVuuogCBQ5kD4jrrmWcK9JRw2Ams+CRjcjIkFclm4wfAgEvnKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TEAZf3vv; arc=none smtp.client-ip=34.2.86.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TEAZf3vv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789622816; bh=yj7nKyFrj7zU2yYnwm4/LaF7qhH6Xk4MypSMzLI7D08=; h=From:Date:To:References:From:Subject:Reply-To; b=TEAZf3vvjxl4u/uBCi0ePvIo7latzSuura3jQ7JbkwrCIHaiJxEgE3uWNH1ED8OFyqbdAnC4oIgCGWWPSIVT1YG6+exAGRfuyuF28m2IbyiBPbynLFUMZr8WCJ/eLr1WQlTRXUiRtA62z8IAcJauMsBgrUdrZOMlEGOyshZtQJSSzLHIb8AP9dpCDmCRdyn/XM86P3SYVEJfvmAolQsl32OK2ufDA/4fsQ6cEpGzYvk1n3GGpmXWbd1ghbHPGf5cIgoR23wimxsqABm6fJ/LaktIHGwz7gd55BfLLTm/lkQIb6BihRcUPyYR3be5fY4dOc+hlChUSzjGilP3a6nFGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789622816; bh=6RpOVa3pATFntKj0oaYREj1SGi+YHsVNypC7mIj2e7S=; h=X-Sonic-MF:From:Date:To:From:Subject; b=JbeSX3HNTKqEBBFktVKj9TrPrZEhQxmmE9Z6uVouBLjBS+Q6bf+zANn4GZBwnZw4pES5nei2T4jK2rLnUTCJvO+GxRqwOB7SLtFj/2y5yENmDaIRuu78zjOgRo30pMX3R2wE3NiO+wSVN/jVl1pYqgHwqN9HV9LNtxGNtY6Hsl4YB2MkDMcEwrQ7rNSDfat8NLfMTKlhr4sIWV9iMJht7vHemlhPbUWqgNWRlcMsToocvWNCAA8FXqCxWHGiRDqtBdEHBluwbi9RUBeLTtSsYTqsIcfnyrjltWvo8Hl50bLmAD+tUaZPhM4os4Oh0Q5KMDrXRxKVNqqGCwemOmy1SQ==
X-YMail-OSG: uFvAKAIVM1mQPDk02OLLPT7OEiPQZfKqgCrEvevfEQRbVrYrRdAa27s2jZkNcDU
 nouJ4f1dTaOyF8N9ZHHSkSXxcYITYwHeqpLeCCdVD.fuUi5srLP8d6bXwNnDcsYKwK3sqxlrlRb8
 X_EbnhMm9nvXF.zDE0qSkDeFvomrjia0Zr3DuzYjmUE8qVlsGc07589emBMwwi7jtQrMJEEEQv0Y
 uL_zB5sB5Bitxz6342LRbFBpMvn_YzSpZwObCy8rLgE0ZL3bij27iIGo4q8NBfdhGutv42xjb3yn
 nNu9_OQNcTdZ7oZrwoYh9NPr_GqcaxgzKm9vGlE0jqLTWNxSf9plJvEVHGPpCMjDstD1.G4gRW8K
 ArFBb0QcnTVDY.D.WkoJG3ZKn7DsilFs2lHzgJrII0SeIQC5HNLsX8Qakv0gbm4TWAXkDys8gHfT
 ABdCIVqiIZYpdsjivIpczuNBET6IJhHukk9sexb7qBpaRLDKuLP7MScYQJ0ZUy7f0feQAn5cnLBq
 UdyksMlFXzs6UAcFDBwSwje5dS6NIQJ_iTWmyn0D7UYErJBqAedT.ISyZCjGmiEIhkDXYdml52FV
 gfKUviT_zjiRvqpbGGToyILTtizI.TuOXeYdIxysxvqJfZIPtV_qwlLs3GY1bWh1pZ.SLvNZJ9Yo
 7Eh9KPjcW6YWpjVfspeGI3FaE8NRscIrCK96rOJiZeqW0LDJUCUl0Y7DvkDLUhGhg3DuMXiZ8kBN
 _tLcFYUbY4oAXo7wsSdgu0oNikg2m2w_kPDXkJ74uBk1u1F9.mGx.c8kgcdoNjFlKSJoP0ofaCZY
 Ph7fc_NEa.bVK61lxPDoDS97t6Kh5.C8ETsS7OJIjrEkl8K3hSwSYL8kCgsFYeXPp9skM6094Tv1
 xlSMKcyHDmxc.8mgztcHr64bCfMpn1UOtd5ciKVoUKIurqGq6K6YWUwO2QWgXwrnwQ6.XKPmtMMY
 m6bM7SVXOFov.Gcv.KFpGLKvMNWGqCJQcDmC6gvR4y6lCDUP1oWp.T1vGYTCbTfXoNKKHi5iEHbs
 WR7ooe4wIAplKU7hQ0KQ6xClcYFoR2H5NNYep1IdQPe3Lq00eN8g1CNU_vx8KDz2t9TgBA4i3_X3
 x5Sby8SIwf76IsqAnFB9mIzEvYr_e4DkVrR7tojAd755kX7oBCHDpe8t.Lic0qjNuUpapHnUYQvj
 iJ1_MEUT4DkN2hBaTAqFv_pXsOUmYNN4znB2BU6MXWiqYIajIacWmDbKD.m2mpK8pPMMusqft9j_
 2y_wIXV6SRWe8a4cal5frOww3d4VmitQWtGP8Ui_S7_Mm7aaFbb4BRW7rYMeEbCl2NRcYWU.uYoU
 kcYQ1mS4drH9HJUX2pY3dB.1EZKtX0zqCmWBHtKUsqVR2Vr4iSRcWG7KWtSzZCra18FYSSfPusId
 ._WwQeHB0ejgV_zCPoSO5fwIWByPCndeIjtBvEvFkeConqR771mCKt97AQr_uTek5akEAorKb4F3
 E8PI_Qhm7jkp26DqinvbNFM3qQOQeoGDy3062p_8ldEP763HrHNRkcUbRQJXnMIy.l59wQTKiEVP
 6hLhdGT0zfaJ4ny8pdLTu3K.4xnLtSj8mePwgftv9GF8B0aMhbhQ8jzQIz2fpOhOhiSMdp2N9ozj
 kf9aB_8T1hW2yZKf4Ny_r8ANGcR5boTmzPIcN9j7vYQqhqddao9IMgHvJioT95efbRUZsHXxxJmZ
 mbJKtT.IDo1tM5oLKD23GMERl.vv9R0KAUNaHs0ugHLieHjIDFO8OiM10URpZsbyj0RJTEN44vak
 xQ73h2YkmFlduX1zUPkGyYyXmYpMirjS6yL1WE7AiB_YM9jxZg1RfNazKsAMw4_3QogG19acHpyy
 l19wYUxdICo2iYzIFjOZS2Obgb.Z2bVIna8QahHxevAldj.BpV6rxUEPv5cus8VSyUwSdCniA84g
 tK1b30QYMLsJ4_ImJx6p6T3bmH2Lug2cnlKGchqOWFpqugUd0FiIXySf9uqX84fu8q4rgQpX2.PZ
 c2BTGgByRb7FVUu3X.XcJ
X-Sonic-MF: <bilginaksoy2003@yahoo.com>
X-Sonic-ID: 758347a0-38e9-4129-8d4c-1fa34b124067
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe4-prod-sonicconsumer-svc-102 with HTTP; Thu, 17 Sep 2026 05:26:56 +0000
Received: from dip28.lsn.ir2.yahoo.com ([87.248.99.37])
          by hello (SMTP) with SMTP ID a17b54e4a7f85bad19ffc16c58da67ea;
          Thu, 17 Sep 2026 05:26:54 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Bilgin Aksoy <bilginaksoy2003@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 17 Sep 2026 07:26:43 +0200
Message-Id: <0DC84B93-70CF-45F8-A9EB-2C3DDE79A590@yahoo.com>
To: linux-fsdevel@vger.kernel.org, majordomo@vger.kernel.org
X-Mailer: iPhone Mail (23G83)
References: <0DC84B93-70CF-45F8-A9EB-2C3DDE79A590.ref@yahoo.com>

unsubscribe linux-fsdevel

