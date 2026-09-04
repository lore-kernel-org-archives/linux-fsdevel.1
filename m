Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275726159E
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788486441; cv=none; b=S9sewsXsh7pe/CnfvGTjtRPDrh7Rc2fycqA5mG6H9lFDIesaVTeqwxXZB15fE3pJ1HUafYhxm71TFVRfwnlz5GgKPz7CA7VCN59u3J41E5KH/7jRHd8glhaAHCQmr6w1FCtMVksHmqjDjB7SgAY62+FskwbsaDHLYAFgQtTVhIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788486441; c=relaxed/simple;
	bh=N/3C5zaEOAKyN2Oiv7/u5NzJv6efo77Cl49KeZ2r/OQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DFRTfVu3ObPblDwqWZsn/70s3RzC2b4BCwaxvefA8Ig1Udm0FK2SpwQz/t6z3xuNeEQYSaZDJ0xLOONceZHLbwDdwzjn4rKNl3m7rKhlkOZ16cKUzLRTgJF8sKwssf7ENX4a/2VkluexhuOWNg0Xn6IXoZBbn+UPjOsobve8kU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=mSeQcdvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p5FSwo3B; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="mSeQcdvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5FSwo3B"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE54B14000CB;
	Thu,  3 Sep 2026 21:47:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 03 Sep 2026 21:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1788486438; x=1788572838; bh=UUVR6YN+g0CF9YVa5PuHspdZOQPG+DNL4LW
	0gYEl7Xs=; b=mSeQcdvXXKlRn3ye7tz7W14X1ZSabB0VznZndXvygs6ZDZHaYKO
	SCXRyMwMMoCn5EtqB5KdHeqDy4/e0GuGH1kXyFfoYOE0JrDsjRFUtk5Cb8ftnsdJ
	bALi5z4MMAf78iqWAQ4lBXut7MBzpCls/BKLgTptfToW12uxI75be7B+mxQpHctw
	RL8M2BRWshFdYSlsiZuZKmC+RV+H8Epm6ExlTkb2tfbqUqWaQw0Vo9Z5jIe48Ydp
	gGmMbSP2AdQ4VnxtFIaDdPtHd22I3XgMd8aWbVXwwVZ7i81m2tzdZeiWFuZ2vKlM
	8XHnUT3nxgfiO5Q6whXWISFtBnl5SGuAarA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788486438; x=
	1788572838; bh=UUVR6YN+g0CF9YVa5PuHspdZOQPG+DNL4LW0gYEl7Xs=; b=p
	5FSwo3Bd3MHxkUZO85FKhDns5kVHEQ11zQEdpD8UAWOm/d4RV5wru0sBSRJyCRZT
	q4t1AdSs5Sfy5XQQse9737Usg4IAWSWNw8v9qWnyNLcGcke/lnuJZHS02s8HgLnS
	c2DVhDHX6ZIWY4TY5OE1j9EKv0pGbIPcy6QBpjgVa5jKRuq0WSKdzMUuetHIGmAL
	aCrDcwGvZswN4tgCwcuQFXt/4pg+xio62ffkC2rScX0AEKS1uA/TMXFuRjgeZxRr
	BCpY+zs1BZoxGb1r+muRuuLhtwmNFAiqySNCzWurOAV3FGQekGSf7pJCGIO0HN5z
	dtuHBfhsWsD1uUVZTtFfA==
X-ME-Sender: <xms:JSOaaowiJY1BlO0QN9oyOuHh5EdjQEYjWaUPtm2kCBxlHmq2IUeieg>
    <xme:JSOaamXdNgkfBXRFulR84vjOYCpWPhCFdGh1XZyJeP7mTIkirD0Ec8eyX_d1qJcNO
    lZLAz4aCupxIVV05ujDmqPghuKihpnAVskwkhWe8rjnGvcZ>
X-ME-Received: <xmr:JSOaaqNdO1oQZTN7V-4RLCpCG2R3I7b1kNoMMDpWJJsTceYBgdL-4UDmBzMz27PRzP6ijlH_I6KkqvWr6ZurKJliuB-wlwc>
X-ME-Proxy-Cause: dmFkZTF0tiZ1M4gAamiEcNYAu6it1Rm1iMqup9+Ok+4+RHZhmKB5Iaz3KjSvu+0n30ykPF
    RT2tm0xdanjcuyuXcyZc2CYOOYzEDFhOQIApQmNtHkeEY0GuC5x8ZwAyXNzlyYCxKrxxuH
    ieEcCrRcyPHLDGf9WWpIxSqTUyhe8SAPfCEh6tqwd8t/UDzOg1XBR3r3/gS85jOEDvoAtd
    YOTEi/22rjbujxyDxIgg+SJmX61Y86Bp/T1DRX/yYq0sLi0B/zUDh+AnHPSVVLXqzBVvrU
    g1UNGPVxppAB5BUk6czuQIERWuAQXRJcWnOPBH9NO/9FWSFrwHhtJku9KHuJ4ItpNamzJ4
    K6+4oTVRWj9P0bgX3DMWhRlJhTNa3zWbUmcRPdzMlapfIi/SlX0YzSEne0hV4dC2ewQkxD
    8oIKJyk1CHlwyM9QM29Dik7mTDEpgndclBSzhFL6YDfnZadsCNRMz38Jdloa4ufMNnkBtl
    5Du4oHvuR+rN/gaUwYWJUWQjXcCIUhrsl2IODnQWSolup8Y01NIOhl+m6JZzptTkwBsY+q
    UH6+bcLcWWGEbcVoKDtZ8Iw65cHNsGu02LXLJaH9uNaILX5Y/KhArKUE8xWHkwC/QSCAhD
    SU7RcIY9llWyyPtlnHieDZhqhBTgpHWyRw+/I+UKNDJmpasjy6n0YPMdzo5w
X-ME-Proxy: <xmx:JSOaaoBLFPzilkiRXCVrOuY4zpC_gkOtl9jrY3Yu_fvz2XX6Ah5BBg>
    <xmx:JSOaanfjBb62ZmLqp7oDI3GTpepA0xFa_uL277VsFsc8-7gdXgx3Ug>
    <xmx:JSOaanPhe4uDOhOl2y4a2vyk72ilFzUeVqXXBhRsYMBpgGU1YhcDmQ>
    <xmx:JSOaanLejmjeDhQ88hE48hqr10tjMquIUb63vqUmi0xkjyg3DejxNQ>
    <xmx:JiOaahEONDbbp_gJizIcHZgpASk9tBU2R7Pmirpwj-JcBNeVI7f5rddN>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 21:47:15 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Subject: [PATCH v3 7/6] VFS: reserve a d_flags bit for fs-specific usage
In-reply-to: <20260903032431.142777-1-neilb@ownmail.net>
References: <20260903032431.142777-1-neilb@ownmail.net>
Date: Fri, 04 Sep 2026 11:47:11 +1000
Message-id: <178848643139.207413.1358009499219351091@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

DCACHE_PRIVATE may be used by any filesystem for its own purposes, much
like d_fsdata and d_time.
I plan to use this in a similar manner the way nfs stores
NFS_FSDATA_BLOCKED in d_fsdata.

Signed-off-by: NeilBrown <neil@brown.name>
---
 include/linux/dcache.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Sorry for the late addition but I'd like to include this patch in this
prep series.  I have patches which add NFS_FSDATA_BLOCKED-like
functionality to afs and smb/client.  Having this bit available will
make those patches a bit cleaner.

Eventually I'd like to build on this to move d_time and d_fsdata into a
union as no fs needs both (only NFS uses both at present) and to include
a u64 d_version in the union which will be better than d_time on 32-bit
archs for at least afs and nfs.  This would make struct dentry 8 bytes
smaller on 64bit.

Thanks,
NeilBrown


diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index e7e3ef05313b..adf239f8205f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -238,7 +238,9 @@ enum dentry_flags {
 	DCACHE_PAR_LOOKUP		=3D BIT(24),	/* being looked up (with parent locked shar=
ed) */
 	DCACHE_DENTRY_CURSOR		=3D BIT(25),
 	DCACHE_NORCU			=3D BIT(26),	/* No RCU delay for freeing */
-	DCACHE_PERSISTENT		=3D BIT(27)
+	DCACHE_PERSISTENT		=3D BIT(27),
+/* 28, 29, 30 free */
+	DCACHE_PRIVATE			=3D BIT(31)	/* fs-specific flag */
 };
=20
 #define DCACHE_MANAGED_DENTRY \

--=20
2.50.0.107.gf914562f5916.dirty

