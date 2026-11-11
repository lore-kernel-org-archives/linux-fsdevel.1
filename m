Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413061;
	b=31laKR9v2dwHyBtWAGL5ESqBXH3PXy+7cHBcAVoVXZG9GRirTwRrpQtxAd+IBU7KxPHE
	 os1v5kwKqiRlO7oI0ggT5lsipvvsnl0nvAknBF/LnBnmeRXZ1BSwdxf7HvU7PkhIHccY1
	 YNphp7Zzlj9hAi674xC7bsxdf/vPwcG4uSvoW8ONvIMZYKDI/d5Y2FyWjslkQESCHKA+Q
	 ZF3soe8eR4bros/wjt0Z96bVhFTAjU4w+WAPDH1U/LpQ3XotDu8Qz9+AOh+zc4tRoMctM
	 0HPGrp8RCEgN9wUCNF1UofZCkn3ju27VoH5TVMlcx9AM0Mba1fhNZKJ6Ns0GElRWibQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=oLiHtW1IYWviyikS/FAqG2SZj+wyS6mvRmQNpt7Hgw0=;
	b=XvcnlLVvoxqp99W/dcCANr8cjbblNJ6QV0aa/3ZJrySIpC2e5Rgt9GDYt7srPMxARW2j
	 KPomdPcmEAuVA/QvInLBPAoYS60PiQHyGFoa2gWAYVqJHeygzB3eiHJf06Lo43XLw9PAD
	 DBHNz+iaoWEiB4FFfniby2rHl1gopEH7Z1OXb79LGtBpBZzAbce82tn1Hmp8at+CREkC8
	 dbxnTMVRZNQZSm3RfDx3ln2dVQ3rvGjNEDfCEio1HCqP9WSHeYEjAnDtC69eLVMtPFllw
	 yK0ek4O+6It6vVBy4HXihrm5YvU0DclrtS6I0zrZO4WOChKvR1k4OTUlNs+ltpE1ljg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.org;
	spf=pass smtp.mailfrom=fastmail.org;
	dkim=pass header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=0wRtk7Vb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LwTCtSl6;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B058606A330
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 16:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B058606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.org header.i=@fastmail.org header.a=rsa-sha256 header.s=fm3 header.b=0wRtk7Vb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LwTCtSl6
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DAEADEC05CB
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 11:04:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 11 Nov 2026 11:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1794413060; x=
	1794499460; bh=oLiHtW1IYWviyikS/FAqG2SZj+wyS6mvRmQNpt7Hgw0=; b=0
	wRtk7Vbu4qPa3jkeWXJsVe3XpHniq96YJDPNGYFwdQIyfbem8mvqLbUDtWHyGzmN
	K4eTMrfqTGOqntwbbegpzQ40hVDi5f8DVNZZRZT4EMCWPou+ij9f80NHYQ0UwkEw
	xpb2SPIFcTnTVAQyWbm1CcC9HUnX9/R0kU5PBqq1r5gRKneAqv5l0cEsuDDCUB0g
	WIE8dtHqXN09H38fSYnY3Hy/v0bcuA/Gfbuh2MjeZjSO+HRoAy9/6Oovf3FiUtIQ
	glR0h2ywMNrGB+AOIhVkXH5cmCb5SxIKwnZebz/xTOp6I3sVQK7EjtsF1aA/lqhO
	M+GDeYlSVSOEpPnpMMdOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794413060; x=1794499460; bh=o
	LiHtW1IYWviyikS/FAqG2SZj+wyS6mvRmQNpt7Hgw0=; b=LwTCtSl6u2zylNHp/
	zNMY84lt8JpZVUrkRWIv2tHXWN1HfDVSvAd9FpyJ0W/qM3g96akuiv3PD4UETpAm
	GqOBAUkRKI+NHreEuvSrfaaUItgDpD9TiOTMmO5TkXkbhJUu0QV5/Ph2tPcx42RD
	Vk3T/e0//6TRBdZ2Vcw+QWDfx//duU5nKPhnaJB7emUeecHwIXAvMoA6TPU/RbWh
	D+KD4VuG2VX7AoylcNXPst8YVf6fxgU7ABOxjqu2BGyj3drIekA80gCg3+4lEQ5y
	jmkZxsf5WSekMVJt7KefG0PXBn12JHdBE12DSO8IUgYCw60EHAL/XZ3cU2ZjGtDf
	wsJHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794413060; d=fastmail.org;
	mf=PGljYkBmYXN0bWFpbC5vcmc+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:OetnhV4RJytGkzb6poCbb3ocQfwrw52QlZuOBsvtaIuEUtf
	b3UWu1uung1aoDKF+RgGIhwFFkihssh3tTcFIdSJ+vVIqvAPKdRhDCG8sxfZ2Bh4
	zrwigETXH/BXIVMiLI3HEdEovW12rfPqXlghwcjOEpmyDzC+HM850sZtBZhUgEKz
	awRvLzXSaRomhPktBYtPhf5DQI1lcTcR8QJUH86NJl9oW/ojspGjwe/yI8GxTrqF
	Hge9NeGFePfYpqJ3owuJUmwE3z4+bIhS8ZrG8Lqk8sBDgVPiKISVyAGOfO4XKk3l
	Sk8zxCKHqqmS+OLlCyKKhnemKAmNq5LJiOm04EQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gCneNaoXg656JSH9t9vSZTB2lGRM2xqvRkCld+c4m94=:04ckyKzKkGvGwtxEU/nP1Equz41/B9+PuduJ7pRYoX8=;
X-ME-Sender: <xms:BJL0amdr40xRFVDANoKvZ6_K2bD3boVYzeCIVzCw1T88fpgzYoVS5g>
    <xme:BJL0amO8ST2W8wa_ZkvlFKDb7e96eXzqW68GjZKwBkjWa0RTm0U5ZfyXdAtipsaCG
    -6Fxy7ThdJvpTYRVGtYfLpl1pqK9VHLrukxD3sDu7ABRm6Q_g2A7VlM>
X-ME-Received: <xmr:BJL0aiWRqnAxxKz590pxuLxPzWX6YrB8_uxt2QiWaOFf7oUghuFoeePYA359RhpR>
X-ME-Proxy-Cause: dmFkZTEGiWpjkAqvpdpTZAueIN2nKSWOBCp/471wSdPjoZ6M4A7svfpQVH1R8hL0xV027/
    e/Kc7t5m5zPL0cbReHQKNc5TdJDTo0B9hXmMzycYcte96r8JDR2uPmZPqUWM0DzimKCgdm
    Js4TJUWLPj3WH9yiGOKX/Z1Ijz8WIQ05VA35XI6CHJrBzU7UWxlE6R9xvZ0B/cyNv7Xm3L
    5rKv8i28Vg4bQXfxrtySwyKEQjLwngDFIhc2+Q1N+AdzaJ/KasUAdq5US6/JhmoAqVXSW0
    54pZcTWvZ9LtMFIjdyMWDcT6HAVQSBA88K+xj9JEI1cA3aG9bWoe5ScMMuy4q18OWdN7Bk
    RsUmV+3k1i/B1V6qOPIcJAU6VB+wGvRMj9ML5Y/RZHztul4RLDVZALnl0WoHFpm1N+wsEC
    1rlO/CNht7yh2AxDl+BQRqZQSYXI0HaiQTjVrY39qJYVO6Lg32/1gyUYbydR3WDl5NAq3O
    B6Qd64CoHLbi4Q3TGUvdL2HT+0htQJgEyyj0yb6zhva3JiIiUTQONKaNTvqQ8Hy8Xz2Zy1
    O61vRPsoLDhQQgwi+AZfOGfjLToOErLTmLI3mOm9s8QVMw+BM36M/NWWqkUMg2Al7DPbdW
    vbgBmYfWFurlnDNEVCC3l6q1pug/FKvGKe2izXfWieLK+Jn7igtp3QKkwHTg
X-ME-Proxy: <xmx:BJL0amwbld38cCFPdubpwxHLQikn6dk9QJw6NozRNV3L3qPXD78ndA>
    <xmx:BJL0ah93Ksh6ZnKPc99XG8qUEKPnyGI54fWYJEIL9KCHrZsPzIyIIA>
    <xmx:BJL0aj8YJ3ZbHv6byubii81uFRbLrQY-PJwH_z_Av4UvAtXI14-crQ>
    <xmx:BJL0aoUw0GHheAAwP43ipoZlsUKbtTWpmYuXe7eTXE6Piy1PlP50Og>
    <xmx:BJL0agEvJQ0qT-mO15yRublX2gedDT3edJNUWd5VRMRwsiBKTSOKlvS8>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 11:04:19 -0500 (EST)
From: Ian Bridges <icb@fastmail.org>
To: jan.koester@tuxist.de
Cc: linkinjeon@kernel.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	brauner@kernel.org,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Bridges <icb@fastmail.org>
Subject: Re: [RFC PATCH 3/6] ksmbd: pass the domain of an NTLM login to user space
Date: Wed, 11 Nov 2026 10:04:13 -0600
Message-ID: <20261111160413.4127821-1-icb@fastmail.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <82748744eeaac5828009aab4@groupi3>
References: <82748744eeaac5828009aab4@groupi3>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jan,

On Tue, Nov 10, 2026 at 09:02:41AM +0000, Jan Koester wrote:
> +	if (domain && domain[0] &&
> +	    strlen(domain) < KSMBD_REQ_MAX_DOMAIN_NAME_SZ) {
> +		req->flags |= KSMBD_LOGIN_REQ_DOMAIN;
> +		strscpy(req->domain, domain, KSMBD_REQ_MAX_DOMAIN_NAME_SZ);
> +	}

Is a domain of 48 bytes or more meant to be left out here? User space
would then pick the account by its name alone, which is the ambiguity
this patch removes. NTLM puts no such limit on DomainName.
session_user() also seems to drop the domain when its bounds fall
outside the buffer or it cannot be decoded. Would it be safer to fail
the login in those cases rather than fall back to the account name
alone?

Thanks,
Ian
