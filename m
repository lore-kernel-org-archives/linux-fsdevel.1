Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.33.45.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676331;
	b=KdIRXKEWddBuIR4tzM2npa3i7Leor+QRySVaxa0UHR+NCKEqQul/TynyJ5v0AuarqCmU
	 htPGv9fUTHaLnAh7BcfrLoiG0r5cqNP8akW/ocTQwG6LQzyfUi9+xCbHG2X2dUxjCjxp/
	 q8c/9/hIuHYhOATcrY3H5303cPYiuc9xZglnTFG+ecvOgzuTpaaFCCbRHYWN+TVjP87t6
	 aV6rlE2NZUL5iWm9WD9DtaK60GpEMckkK7B9qNvmJEueEkxgFPXT/Ze3WibT2ew/8TAAI
	 wMdLsqqOY/uyLP2RCtaNHsGWaJ4ouOfmMWDS0RFkPwXrrecW1kzAJwPYgkVKpUk35rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676331;
	h=DMARC-Filter:Received:Received:Received:X-OVh-ClientIp:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:x-ovh-tracer-id:X-VR-SPAMSTATE:
	 X-VR-SPAMSCORE:X-VR-SPAMCAUSE:DKIM-Signature;
	bh=/H+K2zS+8dAW31vNoVpWVBt83T6rRNKuKqYyPbCVKhg=;
	b=ZfSQOu1onRtsJ+Z9uPXlT/xzjEvBgxkBSwHiiI60RegfNjaIXfoXkpvWmxqylGw8X4Bn
	 yiHSgZ95AOm2Wv6Ae+L8uNbHA8h4abYTr2Tts2xc3CK7elNJhLMiSYQGNsC9HvjUL20lt
	 YFnXS0AKqSQkEeK+EoKEui9k2zqVIMi5QOl5Y9zYCmtZkO2u+3bxJGSo+waey7BtHbhde
	 aL4KbNy3CNFaAjo15X22DyYw62vZoSmx2SJFgNB/INTV9VAo0xHeef7JSMGEB9FVoY+SL
	 zeIZSHkvijcB9XfcpeGHc8JBoYGcc0wae1LUWsMGAEPaykRXd5WmdsUCNeoA2LBp85w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=medichon.fr;
	spf=pass smtp.mailfrom=medichon.fr;
	dkim=pass header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=Y8cL4gt5;
	arc=none smtp.remote-ip=178.33.45.107
Received: from 5.mo550.mail-out.ovh.net (5.mo550.mail-out.ovh.net [178.33.45.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A5606A319
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 13:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF4A5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=medichon.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=medichon.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=Y8cL4gt5
Received: from director1.ghost.mail-out.ovh.net (unknown [10.110.37.80])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4j9S0c4Sdqz60PM
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 13:38:40 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-pwghx (unknown [10.110.37.96])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8CC98C0F97;
	Thu, 22 Oct 2026 13:38:39 +0000 (UTC)
Received: from medichon.fr ([37.59.142.110])
	by ghost-submission-7ccd8bbbb6-pwghx with ESMTPSA
	id 3wIpG98R2mo1Kw4A/xTcRQ
	(envelope-from <abo@medichon.fr>); Thu, 22 Oct 2026 13:38:39 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S0042b00e5ec-fa17-45f5-ac04-93ee996df457,
                    D013C644F711C524BA86230872FEC141E60CBC53) smtp.auth=abo@medichon.fr
X-OVh-ClientIp:88.190.90.129
Message-ID: <fefff113-af7b-4a48-8d8b-53e011c51b9c@medichon.fr>
Date: Thu, 22 Oct 2026 15:38:39 +0200
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
Subject: Re: [PATCH v2] afs: Add barriers by using clear_and_wake_up_bit()
To: dhowells@redhat.com, marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 jkoolstra@xs4all.nl, skhan@linuxfoundation.org
References: <20261021145232.64710-1-abo@medichon.fr>
Content-Language: en-US, fr
From: Arnaud Bonnet <abo@medichon.fr>
In-Reply-To: <20261021145232.64710-1-abo@medichon.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 1288029495237762796
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGL5cg6pxP0hbqA39lXjJ0fQyK6neT5LNuv5R1sOOIvSSV4QSNN8z7RNkW+7CoY9WFgWkNpEsgMtKmKwKmt3DqM2pthWK8XE3TaxqnEWcht8ePXUgU/LJ7eN/lG7dYR8l4kzctdBZZXEpegcYRgb6NRJl1/tuyEaaSYi963i9ycbeHOYGJheJzkw3TINT+uPBbwOAsXxClxN57gVx11D6JJi2LyFs6OLigl0IL2J2Ty5M6WzkDPoNa3VYFSfI4Y0KOhkzpukPrRxvC5Tn1WDuCndQylm65zaWuDgb9fNY/S9B2VPmlkQBBtzvhTnqohTQ7IchXI2DgxVI4tiza7Tp8gQvmTvZLinr22JwxjtIkBNHxIvS4nUjum+3i8/fSV3QukiCsZqqVrpjTJiDVE1HSpm+zXXF34099XnjHz9qJCd43uqp5KCaZz17gz6Tzc86kGNX5F3/m+x+pcEv3APtP44p6ikXNkRNX9AyT57R9q0YW4xbCLv8dXi84lQklikRUS+mcl9IXhHkJzKLU0kaM3TgGsyFWrFc2VQLs86WNpmL1Heweus0RNjWGZEaNFS9U+W21l1Uu24uB9d/1VYOb+pqL7t5KViX6F54bOcKVHoo0z9foZGj4NlTZYx7M7pt3g7n+ucY10GtKr2xI2CGA2K2hOTlQkJ/bqsdaYchBONg
DKIM-Signature: a=rsa-sha256; bh=/H+K2zS+8dAW31vNoVpWVBt83T6rRNKuKqYyPbCVKhg=;
 c=relaxed/relaxed; d=medichon.fr; h=From; s=ovhmo3801317-selector1;
 t=1792676320; v=1;
 b=Y8cL4gt5mjm88rasNDkemwlZZyR95X7TgRm8Ug96jmlB90Oy5FHUlUMmsl76l9sMT0KM62ex
 9SbOT8IElcxBy6aZolUfFEWmoXHIxKwD1BBJ0q1NAKdzQtI0PGiwuUt2dF+JQ0ZfFxW8BXHbMeL
 KSBoI+v/raojqluwDCHjBobG0cqGh6eUmwoVRAE82tLf55KmIQ9FwpbPrxFVXSDzyNdG7YQBsVO
 rU/M39uciQlhj/qTPHSklYsqhZ0CcnQ25ubBB/lGSICKgpBXdrH7zxw/qvGgz0sQ5/e8nKezuP2
 HyCBe+h37dre+mGn0aZ/0iKzfKsGjBL47PAr+Gy40Ky0A==

On 10/21/26 4:52 PM, Arnaud Bonnet wrote:
> Tested by building and manually checking generated assembly.
> Depending on the architecture it may:
>         1) have no effect,
>         2) supplement the release atomic with a full barrier, or
>         3) add a redundant but harmless full barrier.
> This fixes the second case.
> 
> Example in server.c function afs_check_server_record():
> 
> - x86: no change in generated code
> 
> - arm64(lse):
>         mov     x0, 2           # AFS_SERVER_FL_UPDATING (bit 1)
>         add     x1, x20, 232    # &server->flags 
>         .arch_extension lse
>         ldclrl  x0, x0, [x1]    # clear_bit_unlock(), release barrier
> .L264:
> +       dmb ish                 # full barrier from smp_mb__after_atomic()
>         mov     w1, 1
>         mov     x0, x19
>         bl      wake_up_bit     # wake_up_bit()
>         b       .L258           # return success
> 
> - rv64(a):
>         li      a5,-3                   # ~AFS_SERVER_FL_UPDATING
>         addi    a4,s3,232               # &server->flags
>         amoand.d.rl zero, a5, 0(a4)     # clear_bit_unlock(), acquire-release
> +               fence rw,rw             # redundant smp_mb__after_atomic()

I misread the amoand.rl op, this is actually only a release barrier
and thus does require the fence, making it not redundant.

This removes all cases of the 3) I found above, however as it is
not part of the commit message I do not plan to fix with v3.

>         li      a1,1
>         mv      a0,s5
>         call    wake_up_bit             # wake_up_bit()
>         j       .L279                   # return success


