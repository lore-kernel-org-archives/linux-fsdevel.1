Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157437F0F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024452; cv=none; b=Ou7ANa3R+Ni3qmeLVFESuHlSY8SxIANPgbrnaYZzkuvzHP2jbxBeCpz6s4PrKDHhRCw6+CkLg9uelL9NKsTFeEYHpxavARFBTmWhb2u33/+sX280SBoOllLMjjsz8LNh5mr5+jAMk9poIwGKdi9uFmHufdbrjwPo6LQMCf/DhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024452; c=relaxed/simple;
	bh=S3hxWCQPMT8XIQzsU477HCdlF2KOvOQcuSSHK1nzbBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZtpNAcRzmd3uFkxP+OYx9UPzkrD6lBOjTloF4iudzyw7MgJl/9LOSMadZnXHyj0MMWsFs/UmBnoVb27rIx2bPyPwfYgVxN1BRlLdR3DecjipbDJfWq5LHoQrexjzQ1kJBf+7ZOZF4dxMbOMMo1tzUhyj7h3cLd3E0JEv/vH/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=I7GcyzZF reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=TLa+VzyO; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="I7GcyzZF";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="TLa+VzyO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1769025349; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=/OSCX664UbG6WyfoVOW1dP6q4L9KvL6tcvUejq4tXGY=; b=I7GcyzZFMwlEasm+dN9GnuyZ91
	9avLMSax1BSm+h97sM8ehoPqwcq5QYAYaJX1/BkTg+sLu8MB+EF2n94AfHQtEKx1r4YYXuSJc0mK7
	mdjZBHVig1w5FpfLWEFRFWun206qseZ9Z8mhiH+1rMlkNDoRpeb9KCOqDfefjrSp6YVS/8z0u3hKw
	Ay5SPfdlvMm9LCk9OzExem2E8pwo9Okliz1sB1UXZpUULGCommQ9MPUCOx2UcxL1E6CRJk1VwyKwy
	6jLOKCaAWbu/ofxUADrrr4ClWPj8i4Iw3RbBPIXKXJM6uT1nUDAYfJFnCe+VqFUZwN1BxXuE3V/mj
	26U1uj+w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1769024449; h=from : subject
 : to : message-id : date;
 bh=/OSCX664UbG6WyfoVOW1dP6q4L9KvL6tcvUejq4tXGY=;
 b=TLa+VzyOXRTkqeIywS8X5KnrEXfJ/T4yibSLDTLOpFBz6FqqZqFr5VJeV1xEIB4jIyvBE
 13R8+FIQpUiTH1d+4vFKbmmwj1g4alvUTad/XuyQndBqRvlmKk1nTVzAyTLV7VuNK75MD3x
 55W41Z6eDYwAqjr3vEy1GB4j03oshcGAymOHbBLY8shtrrAlWjsXmGvHbUnX0QGKrPv6ABK
 UTal06cPuEFUS+WuWgUBi6K/8jnZfGbCSJ0fcOSwL5elYTtUbMOTAp5d/TenkMnS6nZa5HK
 9WtKmehJFymUgDQos2VO/is+kGq0a+HabUwSWr7EBxp+ABRXwgpkQCeQ1JDg==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3n-TRjx7e-LU; Wed, 21 Jan 2026 19:40:11 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vie3n-4o5NDgrkeP7-lgVq; Wed, 21 Jan 2026 19:40:11 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 v9fs@lists.linux.dev
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH 2/2] 9p: Track 9P RPC waiting time as IO
Date: Wed, 21 Jan 2026 20:21:59 +0100
Message-ID: <47f0b44f159084f4032a9424e0e2e586b8640a12.1769009696.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1769009696.git.repk@triplefau.lt>
References: <cover.1769009696.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: jXO4n9bAm9L8.s1dgGK4fcbEU.t3vDSgJNpYQ
Feedback-ID: 510616m:510616apGKSTK:510616s9QkJ0c_51
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Use io_wait_event_killable() to ensure that time spent waiting for 9P
RPC transactions is accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/9p/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index f60d1d041adb..1b475525ac5b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -590,8 +590,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_killable(req->wq,
-				  READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	err = io_wait_event_killable(req->wq,
+				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 
 	/* Make sure our req is coherent with regard to updates in other
 	 * threads - echoes to wmb() in the callback
-- 
2.50.1

