Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE623AC0DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073286; cv=none; b=bQiebH1CsN1n3NdavrQr3Y0Dljdaq4y1L/wnk3LTEYoSPYOycEFXmrrs2DbE2RMcPIAH/2MjO8LJD6Q7YNB3Cu6wq9I+p3ofN75n0W7DBfFNf+9M9a3vYG4EU+1R0pZGYPo3F2tqhkRzuBZVkT6Dwei2cgatsnq9vQrqEMHXCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073286; c=relaxed/simple;
	bh=85qhCblYuczvS4uiC66NQ6WBEjH1TPYKXkvyvKqecDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BH1qFSRw1VEP8IMLfxe95p6cHPLJlMp2iQj2XJXEZMwzR5gBtD7UDJex2iujgWxvsfulm3z4br8ibnQLlGtzJeRqcMT7HwA6ES8JCDVn5PFeB9fJT9ZAstX7aNc+EXvUEupE+5BveI2d7NO1mxOcS40qTTZ7rPVS5GoUv+gi/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4P5AzpP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4P5AzpP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B2B3C2BCB6;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073286;
	bh=85qhCblYuczvS4uiC66NQ6WBEjH1TPYKXkvyvKqecDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G4P5AzpPuga0qTmOw+h0eZ8hgi8KBR3it94o1tNjmmU2BwLA+IOKIUylXkU2BEGya
	 n1IQfQ9PUJ0Oyv8eNFaqJlkIoeoYdOrPC5OfQq8tZ8EiNDa4DdhE+2+KHJFJL+HIcA
	 ynefhYrbyQ+BZNN8gkpxR0aDpiijbLQnPYoZKKMFSJu4mQY0CGNomP5Td40vkyKWhP
	 BK1bC7TqxBkHY8DlFbjuoU2HjOt4yKiPygGglmyhrN6h/+cC0UbYYKDBSm7zu+Quuz
	 Zs0vObZknfRrXyS9JnPT0Wef2Wclw8EqEPMw3IbK5Kyjy5S943DeIPkaAH6nFvZmr9
	 2d8+Iu1NVK2Kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB9EBFD29;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
From: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Date: Mon, 13 Apr 2026 11:41:27 +0200
Subject: [PATCH v4 4/8] fuse: Fetch a queued fuse request on command
 registration
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-reduced-nr-ring-queues_3-v4-4-982b6414b723@bsbernd.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd@bsbernd.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776073284; l=1270;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=SapXYOUPrCC+IfOqeimWzfPE/HV07KldNfKiLGyNNSw=;
 b=EPwi4FVaFDjmBp1J7pXGISbHKeRMNU6yXZhtr9LXA/DIa/R4Ri8og3SaXvHdYKA238G3sR5Nm
 dzLTbGaM0YtDTc0b1ndUrv9C3DQ7byXzVIabQqvKXpMvAwEUDSFm8ID
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-Endpoint-Received: by B4 Relay for bernd@bsbernd.com/20240529 with
 auth_id=732
X-Original-From: Bernd Schubert <bernd@bsbernd.com>
Reply-To: bernd@bsbernd.com

From: Bernd Schubert <bschubert@ddn.com>

This is a preparation for the upcoming reduced fuse-io-uring queue
feature, i.e. less queues than system cores.

With the reduced queue feature fuse-io-uring is marked as ready
after receiving the 1st ring entry, as any available queue
can now handle ring requests.  At this time other queues just
might be in the process of registration and then a race might
happen

fuse_uring_queue_fuse_req -> no queue entry registered yet
    list_add_tail -> fuse request gets queued

So far fetching requests from the list only happened from
FUSE_IO_URING_CMD_COMMIT_AND_FETCH, but without new requests
on the same queue, it would actually never send requests
from that queue - the request would be stuck.

Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
---
 fs/fuse/dev_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 1d1305d38efa07641128a865aec1745d2e040b93..9dcbc39531f0e019e5abf58a29cdf6c75fafdca1 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1196,6 +1196,8 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 
 	fuse_uring_do_register(ent, cmd, issue_flags);
 
+	fuse_uring_next_fuse_req(ent, queue, issue_flags);
+
 	return 0;
 }
 

-- 
2.43.0


